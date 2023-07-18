Return-Path: <netdev+bounces-18637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F100758186
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9511C20D51
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC591118C;
	Tue, 18 Jul 2023 15:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9310952
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 15:58:18 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6FAA9
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:58:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666eb03457cso3746444b3a.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689695896; x=1692287896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91916OdaNtuNU7V+LSmrrihsXUvi9Px3IIrwBZBnog0=;
        b=xOoQUCpKMGuQPELmVeOk8FzTtXHZHM4NaizXAGgAFRJQ0MS+RtuF7mVfMNI22/Iaxz
         Uq+nbVRhlZzh0pdKEdsy+DuijMoTMtmJ9OS6wrJsivn+EBGGmSEiTL5BPpVQjr/DoDqX
         UBQoO4jJ0xDWCnQV46Q1Sevn3GAXTSbb4+WeQ/o2earSePBSXcTb9r4oUZts5qaNxVAi
         KWhlcqOkUsUMcADXmZxZi7Crjqo7M/O+EtQylYwtzE8IFhued3PQujZJxV1LtJZE19Yb
         MIPwuK046IztntoysbvH+y8gsOzxmtjbMOMGjedZOopepBDRbiwuI7LPVOWYp9w+kIJb
         yuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689695896; x=1692287896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91916OdaNtuNU7V+LSmrrihsXUvi9Px3IIrwBZBnog0=;
        b=E7OndoP15GRcrtOmHUDGYLV+GGXfzqxFjC7/w60x9Gb5HLWNdaZyVO/eGTnn82Ufi4
         sjUIhAYGbhOLKwHlI49X3EeOtNVkSUIywkAoMzg9np8TdAOgGcns32LZC+WxqMA/lbYN
         gAHeidiGHf1/txF052ringAeiC4YP0XrtToNf9jVEzsfKjsB4Yo3nJ48+Wz8soUbZTI9
         VkGQaN1qhMtdffoK//PzLUJUylhJQeyQD3wkevVwrkXc29JoegJ4R+yOro+RDH0KSI2k
         uJkP070r5OVPgD0eSy/s5rb5+zh//XtYUPFqitG/FJW+pGXn/Ho5poarp+dIbzS21LQ+
         JrcQ==
X-Gm-Message-State: ABy/qLYfXPfV8ae9qnQhvaTMrTXoiknMaBzE+6i0qU4HP/dYlJ6CotS2
	i4sXD4+K2InFaN14+2eFzVbU0Q==
X-Google-Smtp-Source: APBJJlGQgMweVxwZ0BmECKoBgi62tpEmv2gkY+WPYIlDKfoOE5qinnmfoBQCLGwz/W6fFbadpPHaaQ==
X-Received: by 2002:a05:6a00:8d3:b0:686:25fe:d575 with SMTP id s19-20020a056a0008d300b0068625fed575mr2410800pfu.11.1689695896294;
        Tue, 18 Jul 2023 08:58:16 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id t14-20020a62ea0e000000b00680af5e4184sm1691811pfh.160.2023.07.18.08.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:58:16 -0700 (PDT)
Date: Tue, 18 Jul 2023 08:58:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <20230718085814.4301b9dd@hermes.local>
In-Reply-To: <ZLZnGkMxI+T8gFQK@shredder>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
	<ZLZnGkMxI+T8gFQK@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 18 Jul 2023 13:19:06 +0300
Ido Schimmel <idosch@idosch.org> wrote:

> fib_table_flush() isn't only called when an address is deleted, but also
> when an interface is deleted or put down. The lack of notification in
> these cases is deliberate. Commit 7c6bb7d2faaf ("net/ipv6: Add knob to
> skip DELROUTE message on device down") introduced a sysctl to make IPv6
> behave like IPv4 in this regard, but this patch breaks it.
> 
> IMO, the number of routes being flushed because a preferred source
> address is deleted is significantly lower compared to interface down /
> deletion, so generating notifications in this case is probably OK. It
> also seems to be consistent with IPv6 given that rt6_remove_prefsrc()
> calls fib6_clean_all() and not fib6_clean_all_skip_notify().

Agree. Imagine the case of 3 million routes and device goes down.
There is a reason IPv4 behaves the way it does.

