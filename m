Return-Path: <netdev+bounces-25470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C477437C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DA91C20EE4
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84B41643E;
	Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D05168A0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78001160AE9;
	Tue,  8 Aug 2023 10:13:12 -0700 (PDT)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1691503677; bh=JCNxuh7snRK2UxJGDtGrIxZbmzWs6fAjEgbNbIIekR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=wizfIvOD0Xel224akMYsYN2NAFu/z8AWfHMpuPb6xqrHKSjejQhOalNbVLjtbrCvP
	 c/aGldFz6MmxcsAfpne4d1lPZMY5f4Q/fjdw8DbX+hZDhU6PMxEAVGjU+8EELiNb8G
	 I22pBkwsDBQra2XKcWihEUdCelKCVxrhBya0JIT8K2CM0+E5qkPWTo10SgRv+kQCxl
	 MDGnO7O3lTfIiw+QV4cPlUNCkLrwxLBLw6mEuH1EYp3yJostPLnyrgB0V9IoJIC4Lv
	 WlBoU3ytvhzutDC9N8uf9oLhudBBgN9xbctm9hlvPHkcylTGWurHQbxeXMHo1Ixzn/
	 fHNcREXn8JrUg==
To: Fedor Pchelkin <pchelkin@ispras.ru>, Kalle Vallo <kvalo@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Senthil
 Balasubramanian <senthilkumar@atheros.com>, "John W. Linville"
 <linville@tuxdriver.com>, Vasanthakumar Thiagarajan <vasanth@atheros.com>,
 Sujith <Sujith.Manoharan@atheros.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Khoroshilov
 <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org,
 syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com, Hillf Danton
 <hdanton@sina.com>
Subject: Re: [PATCH v3 2/2] wifi: ath9k: protect WMI command response buffer
 replacement with a lock
In-Reply-To: <20230425192607.18015-2-pchelkin@ispras.ru>
References: <20230425192607.18015-1-pchelkin@ispras.ru>
 <20230425192607.18015-2-pchelkin@ispras.ru>
Date: Tue, 08 Aug 2023 16:07:57 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87bkfhbpaa.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fedor Pchelkin <pchelkin@ispras.ru> writes:

> If ath9k_wmi_cmd() has exited with a timeout, it is possible that during
> next ath9k_wmi_cmd() call the wmi_rsp callback for previous wmi command
> writes to new wmi->cmd_rsp_buf and makes a completion. This results in an
> invalid ath9k_wmi_cmd() return value.
>
> Move the replacement of WMI command response buffer and length under
> wmi_lock. Note that last_seq_id value is updated there, too.
>
> Thus, the buffer cannot be written to by a belated wmi_rsp callback
> because that path is properly rejected by the last_seq_id check.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Given that the previous patch resets the last_seq_id to 0 on timeout
under the lock, I don't think this patch is strictly necessary anymore.
However, it doesn't hurt either, and I actually think moving the update
of the rsp buf into ath9k_wmi_cmd_issue() aids readability, so:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

