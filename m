Return-Path: <netdev+bounces-169653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F23A451A2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 01:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321513A1753
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 00:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA8313B293;
	Wed, 26 Feb 2025 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHmlojCd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6FD383A5
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530492; cv=none; b=TMJgzUcihLi+r7Wf8OtdJAXSHJVjX6d8coSOdiathBBZvCqm5c2ovOJdDFQg+aAkk1I24wzeebE9gseOk6wASKUMllPwdtFf64/riwEtu0Hah+QcRFDlEgyVXPZqt342ZPs1gKlJMoVLQCDQruMjGJY4mu+PZ3ilXQZoKWBhsl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530492; c=relaxed/simple;
	bh=OL+o8Qr7rIGXzmzq4KGE4iJKSK7MeIejYtDCwfovlw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqN+fOHWTNiG91sIXyI8Xxbi5bK5Dle1xTdMYE8NzcdLO6YqnGuvpjozagl4y524BEkVbNXjqebuqM+JIsNyulwxehh1/u0prjugOFWgU3XXRwHUJUbiaFKF2FP9h69uzF0f0M8gz+pOOkbDsmV21DLSaxDQ0a76iGE2yUWazbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHmlojCd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8f38febso131211845ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 16:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740530490; x=1741135290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nd62dGLUhc1OD3FinEgBzSlVMCekLQ/3De2rlqBs2P8=;
        b=QHmlojCdgNCtjVyIUkahq0ooYJD+aihLnj4JGvQxWlIHKSAjYqj50axWbUyG+dpKvF
         nSAawSskH1GmejaiaY6LLmOT+e7DIWw8aRfxlh0eZKBpipqM5HXBrMNRCSTyFGbAqI7z
         x1Bvr6bZsuZfp2Elmd+ClqjNPQXA2fze9n/biA8ZFfo4abCvXgGFkJ0pNs2zmRD1I+/U
         578iEAd7aKSbUHnaoFV2AP8BB/+vD8IUTWt0F4Gsu/b+szwkoO7gVwU5CoURy+zgv/4k
         d1rXpdHCuQwY69E0jyaxx8EnHX/1QBNiLanQYBrq7rfuO14/ooNBDHcXjvweOz9xG0iI
         mAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530490; x=1741135290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd62dGLUhc1OD3FinEgBzSlVMCekLQ/3De2rlqBs2P8=;
        b=VQ6Lfs49xJV0AV7pdzWjSLFPHuPxHiq2IjGcMVqMJ0iftTSX6QZ4tVn927yXQAtSWh
         JfjfM+CsiW611YaehBOIl3z6cM9UyUSWEiRfGA4/64CAN7a4ulMVmJd+0BcpcVTyuTxu
         fM5Hm+jK6JIyYZTVCTouokdBZEd6aGcLzi24HN2JgaYnnN0kPFDD4WCqMHTr6TN9t63q
         MKq8DQ+CK4Js9na6NxjWvIzU3sbBn7AGQj2Sd+mC/Dhkh9RzK31FCMIRopvK1t1iX7XO
         WkcoOghAWRMDCSznX2okJJaP97Has5fJHI+Q+XsHG6wIg05qB210oBu7i5gg8IFj9mJx
         4RuQ==
X-Gm-Message-State: AOJu0YziQONB1N0GNsYvrbIoJxMPPpLrwbOJt098Iqmv/BgYgsP/9rMa
	GnQgwHKh/mp1pNeI3BjWhZZtU8VKJr5DX0nIobNpDzib3lZrzW6X
X-Gm-Gg: ASbGnct+Bw/YdA0otdNMVwi684RNcCcbf7odVr/t4TBBmog3yX8klYx1Z1muGBAv3Yo
	9CELvk66M7ipOvixX5dsEgclWtUg7tU0FP3z2P2mKCsEM6cJ8IFdGcifuq5duhjcN2vC0obflqC
	RZCJGw++RdcoAVcPh3jeQQtCPyEGFTvOkh3NJ97qpGHEy8EPOeU5x2RtJ5aYhrijNoZmM+AJxF3
	hV7ywaHGWn3jDIekiWbq8ibabtMHf5vrz6MxINuN9KeHsei6e9g3/EWNi1FC8ipdicXOXbE7eX3
	VQEmG75dgwVL9S4NbJ7y//STDZhRVA==
X-Google-Smtp-Source: AGHT+IFPYW396v8ELENFuNOeFwKEepfH2n++2KQ/y8pF18rSsmwb6rnQBzzAA1QBX7ix/dLsbAKaqg==
X-Received: by 2002:a17:903:32c5:b0:220:e63c:5b10 with SMTP id d9443c01a7336-221a0015676mr331993935ad.34.1740530490166;
        Tue, 25 Feb 2025 16:41:30 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0b0e12sm20697405ad.243.2025.02.25.16.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 16:41:29 -0800 (PST)
Date: Tue, 25 Feb 2025 16:41:28 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, andrew+netdev@lunn.ch, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com,
	Olga Albisser <olga@albisser.org>,
	Olivier Tilmans <olivier.tilmans@nokia.com>,
	Henrik Steen <henrist@henrist.net>,
	Bob Briscoe <research@bobbriscoe.net>
Subject: Re: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
Message-ID: <Z75jOFUVWNht/JO0@pop-os.localdomain>
References: <20250222100725.27838-1-chia-yu.chang@nokia-bell-labs.com>
 <20250222100725.27838-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222100725.27838-2-chia-yu.chang@nokia-bell-labs.com>

On Sat, Feb 22, 2025 at 11:07:25AM +0100, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> 
> DualPI2 provides L4S-type low latency & loss to traffic that uses a
> scalable congestion controller (e.g. TCP-Prague, DCTCP) without
> degrading the performance of 'classic' traffic (e.g. Reno,
> Cubic etc.). It is intended to be the reference implementation of the
> IETF's DualQ Coupled AQM.
> 
> The qdisc provides two queues called low latency and classic. It
> classifies packets based on the ECN field in the IP headers. By
> default it directs non-ECN and ECT(0) into the classic queue and
> ECT(1) and CE into the low latency queue, as per the IETF spec.

Thanks for your work!

I have a naive question here: Why not using an existing multi-queue
Qdisc (e.g. pfifo has 3 bands/queues) with a filter which is capable of
classifying packets with ECN field.

> 
> Each queue runs its own AQM:
> * The classic AQM is called PI2, which is similar to the PIE AQM but
>   more responsive and simpler. Classic traffic requires a decent
>   target queue (default 15ms for Internet deployment) to fully
>   utilize the link and to avoid high drop rates.
> * The low latency AQM is, by default, a very shallow ECN marking
>   threshold (1ms) similar to that used for DCTCP.

Likewise, PIE or other AQM Qdisc's can be combined with other Qdisc's to
form an hierarchy, which could perpahs achieve the same goal of yours.

Taking one step back, even if all the current combinations are not
suitable, please evaluate what piece is missing and see if we could just
bring a smaller new piece to this puzzle to solve it.

The reason why we usually prefer small pieces is because users would
have their freedom to combine all the reasonable piecies in their own
way.

Thanks!

