Return-Path: <netdev+bounces-205457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA2DAFECE9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F952188538D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D212E7BAB;
	Wed,  9 Jul 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDdDW2s6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84D2E7645
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073038; cv=none; b=IHE3358D+wVLTBF+Ax1ksAWJd4sqPovSHiTwTu2jDTz7i4P3Bptxwae5ppRriThZQ2H46/CpVUJ2jXS3MN95xJ1okWlbOLRrE1tN9ugKUPH7Jhiz3REhbfgmIOyJ/ISGOQSfNr/zvIt11UaPl2TFGsak0SkY1MdUVxy6VTUiD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073038; c=relaxed/simple;
	bh=z0KeUw8GcTcwQDMmgIgnjnCbBlIeSkXI6NxiN+WQ2ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sigmj8sKtD58txmll3I3cn/0JK5ekqsY0lqxjuMhaScv72RhaXv25pNahca8NmlhOhsbDRVMVt5Nv/l7Z+j4aYq1dQ1UZCn0qY3LFk/2QnocYTyfdWAlQoh+AaY9VAFFcQ3IU+r+U76ILSYe0GNrpubGkYoyqiYwxz4U6m8f6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDdDW2s6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsDh3n8LHJ/HdhnBV4kSQtvnM5Eyl5B2MMoNaxxIWlI=;
	b=QDdDW2s65GzkmW4uEFB+St4/qf6wH3NbFKUhpyDJN30Ekt9bBhijahimUc2EONMPG9n9j8
	kUllBslv7i/Tou3zjUyjfqQr9HeOkthaQyQg3nyu2Cq1TXhLzBoPyvgOfLjAixBxCoWSOG
	9bP77/1lqOYix6oNHFYnC+0s/hx3hPk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-dQxk1Vq6PxG8y_r_uOoivg-1; Wed, 09 Jul 2025 10:57:14 -0400
X-MC-Unique: dQxk1Vq6PxG8y_r_uOoivg-1
X-Mimecast-MFC-AGG-ID: dQxk1Vq6PxG8y_r_uOoivg_1752073033
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so8209f8f.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 07:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073033; x=1752677833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsDh3n8LHJ/HdhnBV4kSQtvnM5Eyl5B2MMoNaxxIWlI=;
        b=Ea6pPEm+ZkzN1tpUIk/kInStaIk2oS958A/3++wt0VTtx8w0qwdIG11IJ3HAs5AEw3
         ZjnzU0JGw0D7/I2xw6D75+6Fs2AhTK/wizBQ3ocRanE5kgtNljCg4Z1cHQ9pzvccek2U
         QIkhshpwncTk8h6BUK9pxOnYZoqPFrKAFC9A9UOPvb2wYM57V1ZZH59HrdfeDn985xi+
         Eyq7cdj2jmZDbrC5M1FaPj4S6Xvs2aYlaZTAP82GODpgZpGl+yyeUMoIQQlTbNAR3uJP
         4ytZf70mUa4betbZvzGesHvB9jSG1WNTcGLpLM4eggTRoyPAUDtw/mQh/cevv+l/SEyQ
         UTZw==
X-Forwarded-Encrypted: i=1; AJvYcCWP+r03+Gw4gH36pH5Cf9/3ZkLdPAb56iPBJInmS4FkUe+PNUnktTvsSb/nOqlQd2IRR19HkbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+WSfQ1jYVcQiGKpgrzvKSFUa9/mo8DEaP/hxZAutpB+JUDhW
	ugXb97t9K3bg6tpP6I2K+FAqtsh7paVF+InbsfoVm9hVWzEgmNiurE1nxVofp8f93Ropvo4zeF+
	jRzMPCG+tz6xBMeLlw3PKMXfjFejm8E4oew47OwbaVWNUNpkA15phIjy1TY9n0pkWtGwQ
X-Gm-Gg: ASbGncuJ2t75GgmC18buoC5OYY/EmlAVVA9pr1Udf+/8pN7zKc95T9Jm0QLyWKt2DVm
	R3eJEIVFmncRvqe2/iYX1cwfVdGFS4KUIBe0BReeTDwSNxBuJeusqq5p86CBIzA/YsaKrlV/HaF
	Ukjrl3ariHWrIRWUPcFhMZfzVFlUyuosWfJs2hPG/5x0yEDo92JL9W6j8lzINAydseU0noVOLMa
	vY/FS66bq8J2fDKGsLMSTSOp9u9FUSmyqH10Sc9lLVA0+rA58YZNMkg/KImcGt5G1mX1/hyLWHE
	Ee/gbwOHAjMkFlDJ5ppeb2/NmV8=
X-Received: by 2002:a05:6000:2f8a:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b5e44e60f9mr2545134f8f.21.1752073032699;
        Wed, 09 Jul 2025 07:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIDgDZ3ueCPe4xupCxLJP+j8s5t9RvUgCvtE3idf3c2mnCCVDXZoHffqrFFHgTqOqncfSl2Q==
X-Received: by 2002:a05:6000:2f8a:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b5e44e60f9mr2545109f8f.21.1752073032312;
        Wed, 09 Jul 2025 07:57:12 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b975efsm15802090f8f.46.2025.07.09.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:57:11 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:57:09 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mhal@rbox.co, sgarzare@redhat.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, v4bel@theori.io
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <brnvavvmkbxcvzy6ahwyissqnmjl7db2w6yfk5pmipuhuvsdu4@qwoeyioaues6>
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>

Hi Konstantin,

On Wed, Jul 09, 2025 at 09:54:03AM -0500, Konstantin Shkolnyy wrote:
>I'm seeing a problem on s390 with the new "SOCK_STREAM transport 
>change null-ptr-deref" test. Here is how it appears to happen:
>
>test_stream_transport_change_client() spins for 2s and sends 70K+ 
>CONTROL_CONTINUE messages to the "control" socket.
>
>test_stream_transport_change_server() spins calling accept() because 
>it keeps receiving CONTROL_CONTINUE.
>
>When the client exits, the server has received just under 1K of those 
>70K CONTROL_CONTINUE, so it calls accept() again but the client has 
>exited, so accept() never returns and the server never exits.
>

Thanks for pointing this out!
I had an offline discussion with Stefano about this issue.
This patch[1] should address it.
Please let us know if it works on s390 too.

Cheers,
Luigi

[1]https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/


