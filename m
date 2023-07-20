Return-Path: <netdev+bounces-19536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 055EA75B1FC
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D551C2141F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B724A18AF9;
	Thu, 20 Jul 2023 15:04:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCC182DE
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:04:56 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD41BC8
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:04:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6687466137bso600752b3a.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689865495; x=1690470295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIpOGTy+yyZkDszD0Cr0QhomTTBH/FV/IzKfwLly7Fs=;
        b=Bp+y/xoiHFn/+oIHC4XHxkj+8BE7ttNSRndnW1NeP1AF9JkXAaqcqr15wfXFEyzhJN
         vEXJx4pDPX3WymaX/UvIia4bGNOZYDMEz2wl75csRFbtHfqthUF+UHHgfPkRrkGKZunL
         bx6HtMgaTZJXIbmPQ4ciutY9XcIVxFhN7lc8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865495; x=1690470295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIpOGTy+yyZkDszD0Cr0QhomTTBH/FV/IzKfwLly7Fs=;
        b=j1nobyxDQZdacEWiwAWuijU+pKK/iBvXTKOb/aPIHc9ZlJ3Nt97DykGnZAn85K4JJZ
         +6rApzseYm2H97lfFlICrhdNCZDaZnvfUpFADkjFubbHLX8IKoZolG2k8T+V7IcN2ThP
         RG5qPfHJEI+1ptoyTtW2gbGKIj2Vt74dCWLQZ26grVQSTvVqr0qv1i6NJomLXNPt0g5/
         zNTA+BHpXb3xiTxu+2dkDPhkT1wMGEZ2yi89ZRHRGAhlnjSeQJuBQXEGBuHj0P9tjxRt
         BB3/2OdnIEt/pOnyzzr8fh0lYC6PxBU5xPUW4R5XDj8uc68pr2oj1R2/khFvV3yYqjho
         Go5g==
X-Gm-Message-State: ABy/qLaKrQBTjnRjzXqIu11o/g0Vijc2J/gTRfi8u0xRN96ES1mk2wvJ
	UQZ46XO4vh75xNppOg5K8C2o2A==
X-Google-Smtp-Source: APBJJlGp2ZMNuqOESBwBX/es1raySgqaOy25jMZbaYULniJWgUH/4WQOJjZcWh7kU3XwUY6Q0Gtmsw==
X-Received: by 2002:a05:6a21:6811:b0:138:60e:9aa with SMTP id wr17-20020a056a21681100b00138060e09aamr157204pzb.53.1689865494686;
        Thu, 20 Jul 2023 08:04:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x8-20020aa793a8000000b0065dd1e7c2c1sm1313948pff.63.2023.07.20.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:04:54 -0700 (PDT)
Date: Thu, 20 Jul 2023 08:04:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 net 2/2] af_packet: Fix warning of fortified memcpy()
 in packet_getname().
Message-ID: <202307200753.7B071AC7B@keescook>
References: <20230720004410.87588-1-kuniyu@amazon.com>
 <20230720004410.87588-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720004410.87588-3-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 05:44:10PM -0700, Kuniyuki Iwashima wrote:
> syzkaller found a warning in packet_getname() [0], where we try to
> copy 16 bytes to sockaddr_ll.sll_addr[8].
> 
> Some devices (ip6gre, vti6, ip6tnl) have 16 bytes address expressed
> by struct in6_addr.  Also, Infiniband has 32 bytes as MAX_ADDR_LEN.
> 
> The write seems to overflow, but actually not since we use struct
> sockaddr_storage defined in __sys_getsockname() and its size is 128
> (_K_SS_MAXSIZE) bytes.  Thus, we have sufficient room after sll_addr[]
> as __data[].

Ah, so the issue here is that the UAPI for sll_addr is lying about its
size. I think a better fix here is to fix the structure (without
breaking UAPI sizes or names):

diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
index 9efc42382fdb..4d0ad22f83b5 100644
--- a/include/uapi/linux/if_packet.h
+++ b/include/uapi/linux/if_packet.h
@@ -18,7 +18,11 @@ struct sockaddr_ll {
 	unsigned short	sll_hatype;
 	unsigned char	sll_pkttype;
 	unsigned char	sll_halen;
-	unsigned char	sll_addr[8];
+	union {
+		unsigned char	sll_addr[8];
+		/* Actual length is in sll_halen. */
+		__DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
+	};
 };
 
 /* Packet types */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 85ff90a03b0c..8e3ddec4c3d5 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3601,7 +3601,7 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
 	if (dev) {
 		sll->sll_hatype = dev->type;
 		sll->sll_halen = dev->addr_len;
-		memcpy(sll->sll_addr, dev->dev_addr, dev->addr_len);
+		memcpy(sll->sll_addr_flex, dev->dev_addr, dev->addr_len);
 	} else {
 		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
 		sll->sll_halen = 0;

We can't rename sll_data nor change it's size, as userspace uses it
pretty extensively:
https://codesearch.debian.net/search?q=sizeof.*sll_addr&literal=0

-- 
Kees Cook

