Return-Path: <netdev+bounces-29633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD23784227
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AB9281022
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12D61C9FD;
	Tue, 22 Aug 2023 13:35:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC267F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 13:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F2CC433C8;
	Tue, 22 Aug 2023 13:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692711333;
	bh=Sw6GjOreS9Wn30iQzohzLQD6OAvSJRscDAQK+ZFkrpk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=KQcg6omm2DC5Pi5FP6/A1kIgebA+S8CKE/gVQBs4gI0ro4muCCoAjBg6KwB2yKaYr
	 FuTGat09gmJNt4A7D9df+I6eHKvO4GIrr597oyibY/fdVtU4L1i3H4TdbWdYTiHUU+
	 RZreBL/Kmr+3eQyy0yCf4K8poqLVYDAQTdH9MLNrIDOLsQmo9JAm82yFLikOHqi9KX
	 RvwwK3y5OHyMAE5hc5WBsQF8yfvPFXJ7MDCqxjlGDRiiZ5rLS6O9yiIHwK5x01fS9K
	 F9lDax1BpSXWq8ufNbouow+BJh5X1rMupZYamrCnvA27mDtay6B7q0kYhQVZqLKQjA
	 kmKE/lneXIKIA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] wifi: ath9k: fix races between ath9k_wmi_cmd and
 ath9k_wmi_ctrl_rx
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230425192607.18015-1-pchelkin@ispras.ru>
References: <20230425192607.18015-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Fedor Pchelkin <pchelkin@ispras.ru>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Senthil Balasubramanian <senthilkumar@atheros.com>,
 "John W. Linville" <linville@tuxdriver.com>,
 Vasanthakumar Thiagarajan <vasanth@atheros.com>,
 Sujith <Sujith.Manoharan@atheros.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org,
 syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com,
 Hillf Danton <hdanton@sina.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169271132742.680890.9212359181887346936.kvalo@kernel.org>
Date: Tue, 22 Aug 2023 13:35:29 +0000 (UTC)

Fedor Pchelkin <pchelkin@ispras.ru> wrote:

> Currently, the synchronization between ath9k_wmi_cmd() and
> ath9k_wmi_ctrl_rx() is exposed to a race condition which, although being
> rather unlikely, can lead to invalid behaviour of ath9k_wmi_cmd().
> 
> Consider the following scenario:
> 
> CPU0                                    CPU1
> 
> ath9k_wmi_cmd(...)
>   mutex_lock(&wmi->op_mutex)
>   ath9k_wmi_cmd_issue(...)
>   wait_for_completion_timeout(...)
>   ---
>   timeout
>   ---
>                                         /* the callback is being processed
>                                          * before last_seq_id became zero
>                                          */
>                                         ath9k_wmi_ctrl_rx(...)
>                                           spin_lock_irqsave(...)
>                                           /* wmi->last_seq_id check here
>                                            * doesn't detect timeout yet
>                                            */
>                                           spin_unlock_irqrestore(...)
>   /* last_seq_id is zeroed to
>    * indicate there was a timeout
>    */
>   wmi->last_seq_id = 0
>   mutex_unlock(&wmi->op_mutex)
>   return -ETIMEDOUT
> 
> ath9k_wmi_cmd(...)
>   mutex_lock(&wmi->op_mutex)
>   /* the buffer is replaced with
>    * another one
>    */
>   wmi->cmd_rsp_buf = rsp_buf
>   wmi->cmd_rsp_len = rsp_len
>   ath9k_wmi_cmd_issue(...)
>     spin_lock_irqsave(...)
>     spin_unlock_irqrestore(...)
>   wait_for_completion_timeout(...)
>                                         /* the continuation of the
>                                          * callback left after the first
>                                          * ath9k_wmi_cmd call
>                                          */
>                                           ath9k_wmi_rsp_callback(...)
>                                             /* copying data designated
>                                              * to already timeouted
>                                              * WMI command into an
>                                              * inappropriate wmi_cmd_buf
>                                              */
>                                             memcpy(...)
>                                             complete(&wmi->cmd_wait)
>   /* awakened by the bogus callback
>    * => invalid return result
>    */
>   mutex_unlock(&wmi->op_mutex)
>   return 0
> 
> To fix this, update last_seq_id on timeout path inside ath9k_wmi_cmd()
> under the wmi_lock. Move ath9k_wmi_rsp_callback() under wmi_lock inside
> ath9k_wmi_ctrl_rx() so that the wmi->cmd_wait can be completed only for
> initially designated wmi_cmd call, otherwise the path would be rejected
> with last_seq_id check.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

b674fb513e2e wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx
454994cfa9e4 wifi: ath9k: protect WMI command response buffer replacement with a lock

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230425192607.18015-1-pchelkin@ispras.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


