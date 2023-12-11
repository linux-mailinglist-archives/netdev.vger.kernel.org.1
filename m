Return-Path: <netdev+bounces-56018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D5980D4D1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4FD281A59
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9F44F1FB;
	Mon, 11 Dec 2023 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3fsFdEL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228ED95
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702317532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UMwztKLZjUtaH2raN/EgQXNU0Q/UPB94BCAJoOblMY=;
	b=e3fsFdELSOTKCTP3BnyCVWI95muBkLBeQDZZHNJrHsPCFk3OFlzqLIKnyOtRp1H3DqOfMV
	3zYavDHkP9jyayysGS72Mz6g5oU6xSpfciiP1mEkUzNbLqGiNtEj0xYomn2sl6ZycgvpBq
	+RSXXg7pVLIgLsUbjg7CG5HpGs71LAM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-T6KIGva2MvCelNr8psvosA-1; Mon, 11 Dec 2023 12:58:51 -0500
X-MC-Unique: T6KIGva2MvCelNr8psvosA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c49cb08fcso6745175e9.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317530; x=1702922330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UMwztKLZjUtaH2raN/EgQXNU0Q/UPB94BCAJoOblMY=;
        b=DNXw8S2uLXFm4gxDlPletwH/JMNzxz6k8sjroHFt03BVyFFnSRuTMHzXi7Z3je6vMW
         QXcPf3IzmXOewkYyemdkLRRWH7IXV1KU+G9AGJIgileRwy250tKzxGURcwMeUc8JFJKP
         0kfq7KkkkiKwDbEHSrQMhEDi58BBx5feZS0D/uU/mb8ZAZhkLANvak5Jj7P/kRIJGWKz
         E0IeSEpJL1OWYtHqk70f4VZIk6eJcQARN46FveNsLgruw0TLNB5vqUtrPcpQhOXYoHz/
         xM++uPjBjTX4QcxWWEbNjPIicwliItEQPygRgtBhEo+0esA91C0xc7E5xPxYOQOePDRK
         W8ow==
X-Gm-Message-State: AOJu0Yx8YjiQm2as3gQJid2aTTsymsxf4tpWTDRH+IfdHzAtzjwIIaDm
	Q4CALT/q4uTcMVf6R8qs8C3Ym7qNDKJ2cZ2lMUamdWLOdB+4EnQv3oWqOFsl78KOWIf+QM2M0+u
	ToM8WmoozhMP6X943
X-Received: by 2002:a05:600c:4f41:b0:40c:2572:2035 with SMTP id m1-20020a05600c4f4100b0040c25722035mr2301539wmq.88.1702317529858;
        Mon, 11 Dec 2023 09:58:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjaDMQg8Nd5V2U5Wm0DXYRoWSCknpZoRxL0qmbyFg7kfCeJ9zdP7tB8/6P/mEGQ4ocquC6+Q==
X-Received: by 2002:a05:600c:4f41:b0:40c:2572:2035 with SMTP id m1-20020a05600c4f4100b0040c25722035mr2301530wmq.88.1702317529457;
        Mon, 11 Dec 2023 09:58:49 -0800 (PST)
Received: from debian (2a01cb058d23d600b532f7df3cadcb52.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b532:f7df:3cad:cb52])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d58c4000000b0033333bee379sm9087746wrf.107.2023.12.11.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:58:48 -0800 (PST)
Date: Mon, 11 Dec 2023 18:58:47 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: dsahern@gmail.com, edumazet@google.com, mkubecek@suse.cz,
	netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] ss: Add support for dumping TCP
 bound-inactive sockets.
Message-ID: <ZXdN14BQwrUcpbgt@debian>
References: <87947b2975508804d4efc49b9380041288eaa0f6.1702301488.git.gnault@redhat.com>
 <20231211141917.42613-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211141917.42613-1-kuniyu@amazon.com>

On Mon, Dec 11, 2023 at 11:19:17PM +0900, Kuniyuki Iwashima wrote:
> > diff --git a/misc/ss.c b/misc/ss.c
> > index 16ffb6c8..19adc1b7 100644
> > --- a/misc/ss.c
> > +++ b/misc/ss.c
> > @@ -210,6 +210,8 @@ enum {
> >  	SS_LAST_ACK,
> >  	SS_LISTEN,
> >  	SS_CLOSING,
> > +	SS_NEW_SYN_RECV,
> 
> I think this is bit confusing as TCP_NEW_SYN_RECV is usually
> invisible from user.
> 
> TCP_NEW_SYN_RECV was originally split from TCP_SYN_RECV for a
> non-{TFO,cross-SYN} request.
> 
> So, both get_openreq4() (/proc/net/tcp) and inet_req_diag_fill()
> (inet_diag) maps TCP_NEW_SYN_RECV to TCP_SYN_RECV.

I think we need to explicitely set SS_NEW_SYN_RECV anyway, because we
have to set its entry in the sstate_namel array in scan_state().

But I can add a comment like this:
@@ -210,6 +210,8 @@ enum {
 	SS_LAST_ACK,
 	SS_LISTEN,
 	SS_CLOSING,
+	SS_NEW_SYN_RECV, /* Kernel only value, not for use in user space */
+	SS_BOUND_INACTIVE,
 	SS_MAX
 };

> > +	SS_BOUND_INACTIVE,
> 
> I prefer explicitly assigning a number to SS_BOUND_INACTIVE.
> 
> 
> >  	SS_MAX
> >  };
> >  
> > @@ -1382,6 +1384,8 @@ static void sock_state_print(struct sockstat *s)
> >  		[SS_LAST_ACK] = "LAST-ACK",
> >  		[SS_LISTEN] =	"LISTEN",
> >  		[SS_CLOSING] = "CLOSING",
> > +		[SS_NEW_SYN_RECV] = "NEW-SYN-RECV",
> 
> If we need to define SS_NEW_SYN_RECV, I prefer not setting
> it or setting "" or "SYN-RECV".

I originally considered the string wasn't important as the kernel isn't
supposed to return this value. But I agree we can do better.

I don't really like "SYN-RECV" though, as I find it even more confusing.
I'd prefer your other proposal using "", or maybe "UNDEF", together with
a comment saying something like "Never returned by kernel".

> > +		[SS_BOUND_INACTIVE] = "BOUND-INACTIVE",

And whatever we decide for SS_NEW_SYN_RECV, we can apply the same to
SS_BOUND_INACTIVE, since the kernel isn't supposed set this state on
output too.

So we'd have something like:
@@ -1382,6 +1384,8 @@ static void sock_state_print(struct sockstat *s)
 		[SS_LAST_ACK] = "LAST-ACK",
 		[SS_LISTEN] =	"LISTEN",
 		[SS_CLOSING] = "CLOSING",
+		[SS_NEW_SYN_RECV] = "UNDEF", /* Never returned by kernel */
+		[SS_BOUND_INACTIVE] = "UNDEF", /* Never returned by kernel */
 	};

> > @@ -5421,6 +5426,8 @@ static int scan_state(const char *state)
> >  		[SS_LAST_ACK] = "last-ack",
> >  		[SS_LISTEN] =	"listening",
> >  		[SS_CLOSING] = "closing",
> > +		[SS_NEW_SYN_RECV] = "new-syn-recv",
> 
> Same here.

Well, here, whatever we do, the string associated with SS_NEW_SYN_RECV
will be usable by the user. So I'd prefer to have a specific and
unambiguous string and then explicitly refuse it.

What do you think of something like the following?

@@ -5421,9 +5426,17 @@ static int scan_state(const char *state)
 		[SS_LAST_ACK] = "last-ack",
 		[SS_LISTEN] =	"listening",
 		[SS_CLOSING] = "closing",
+		[SS_NEW_SYN_RECV] = "new-syn-recv",
+		[SS_BOUND_INACTIVE] = "bound-inactive",
 	};
 	int i;
 
+	/* NEW_SYN_RECV is a kernel implementation detail. It shouldn't be used
+	 * or even be visible to the user.
+	 */
+	if (strcasecmp(state, "new-syn-recv") == 0)
+		goto wrong_state;
+
 	if (strcasecmp(state, "close") == 0 ||
 	    strcasecmp(state, "closed") == 0)
 		return (1<<SS_CLOSE);
@@ -5446,6 +5459,7 @@ static int scan_state(const char *state)
 			return (1<<i);
 	}
 
+wrong_state:
 	fprintf(stderr, "ss: wrong state name: %s\n", state);
 	exit(-1);
 }


