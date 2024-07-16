Return-Path: <netdev+bounces-111808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DA8932FBE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 20:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CCF1C21FEB
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ACA1A01A6;
	Tue, 16 Jul 2024 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBTRANBp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9431A01A0
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153450; cv=none; b=awFjUnx9vc7wAIQeMyt9VJiUanP6J/PhW8yoHPNFvIer+0Jc8fndwxnrFGUHs/IoG+/DccKBw5eOaJW7Kxg4p35dvccWIKxd0hRiaP4E41Hm4IMLKi2FKGGdKSWYFmF6Ep0/haHggqGytjIb5hhZ0bXilslXIHe/05ZesTHNO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153450; c=relaxed/simple;
	bh=HuFid8JIh3B5Xe2WMHr/1b2Gwj+HK6TeD5RxU9EXIvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QspwypD8pzC8kXYoedvXLHQP03PwLbirdBTdr1MbGZ9lCuGY9XJUgn2Y03ZA+Zt5F5EBE2b3bAKt1YhUpzTc1eAXlmywYbWKunPlzdwn3VLPq27sTx1BuaF4N6iLU/1FsGSrTzYX9iwLdPPErW6n6B17KRaLGCiz+AYcUWgnxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBTRANBp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721153447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mlk96kUG0oTcSFGygJiwbhbSQeE1UhnXy7eHhiiYJ6w=;
	b=KBTRANBpHpEot1mnQOc4WVePD/LP0p5XKBZQ9FPhn6WyP8D3jrREjFkdalBFGH3m9G4Aey
	wfemm6Nt/nSTqkV4bwmPCQ/kFBy20SJyw5nOpWrtRQMVDF+ECpBvfftTTlY9pqb88AJIeQ
	LxJQLnwckrH2QpjLP1siBOEoI4qnpfM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-T43HYs2FNnSNMbzOLCEZnw-1; Tue, 16 Jul 2024 14:10:46 -0400
X-MC-Unique: T43HYs2FNnSNMbzOLCEZnw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4265d3bf59dso42569675e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 11:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721153445; x=1721758245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlk96kUG0oTcSFGygJiwbhbSQeE1UhnXy7eHhiiYJ6w=;
        b=LM3DwGoMg6xeSXa9FqFxedpL7uoqY4ch56Ew34TmymvDbuc134kKfGu4pXHwUE5epL
         pj5eOZRs90/loWaqItc2ZXrw3rvE9rfmgcO7Vu9OqAgd6WgoRa6vR3/c0YNRXOoQSzuH
         eUiIk3tT9gFjjJJ7wuvaU4CoCTPbPyNukCP3TEL6/dd6nbTH3WydD7FxCBcCV8iGNOrZ
         raPB8Hq6E9MDey+U/QPI7NKbSjmlTDXBHWN6KKiggJ94DkSZewZqwhi6XRh3fmbcMLAQ
         WZ9BFxTmmvkCs21EVNeNOM/v/+M513GlLXIgjQErGIg1j8jWtnYHPC1On2N5RYcUSqgw
         /BIw==
X-Gm-Message-State: AOJu0YzP4pUF0WRZrcTsza0ppqpaK1inIE4s++0i34Qk8U74NMhAMboo
	73HMGwjOWYuuMXLdkpixuB96+GB757QXK5aiZBLkX7LS7e7ed6oqu2+z+jG9feA2eyyzfv2OdHC
	ODdgigxSdKaXA4AVDA/ilm2hH8qud13fWNspvDI9EYT/nwfDKuHS4RA==
X-Received: by 2002:a05:600c:4748:b0:426:5e1c:1ad0 with SMTP id 5b1f17b1804b1-427ba6b12ebmr18994555e9.37.1721153445143;
        Tue, 16 Jul 2024 11:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsTN+bI2U06uNZeKGqNa2R2h8oUliYEhJeA6c9H3Y1f7zq4sLpNH3yRLJH+VoNm8l7hgh1Fw==
X-Received: by 2002:a05:600c:4748:b0:426:5e1c:1ad0 with SMTP id 5b1f17b1804b1-427ba6b12ebmr18994455e9.37.1721153444597;
        Tue, 16 Jul 2024 11:10:44 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a0fa55afsm165894105e9.16.2024.07.16.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:10:44 -0700 (PDT)
Date: Tue, 16 Jul 2024 20:10:41 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	roopa@cumulusnetworks.com
Subject: Re: [PATCH net 1/2] ipv4: Fix incorrect TOS in route get reply
Message-ID: <Zpa3oQuGWPeEyPJK@debian>
References: <20240715142354.3697987-1-idosch@nvidia.com>
 <20240715142354.3697987-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715142354.3697987-2-idosch@nvidia.com>

On Mon, Jul 15, 2024 at 05:23:53PM +0300, Ido Schimmel wrote:
> The TOS value that is returned to user space in the route get reply is
> the one with which the lookup was performed ('fl4->flowi4_tos'). This is
> fine when the matched route is configured with a TOS as it would not
> match if its TOS value did not match the one with which the lookup was
> performed.
> 
> However, matching on TOS is only performed when the route's TOS is not
> zero. It is therefore possible to have the kernel incorrectly return a
> non-zero TOS:
> 
>  # ip link add name dummy1 up type dummy
>  # ip address add 192.0.2.1/24 dev dummy1
>  # ip route get 192.0.2.2 tos 0xfc
>  192.0.2.2 tos 0x1c dev dummy1 src 192.0.2.1 uid 0
>      cache
> 
> Fix by adding a DSCP field to the FIB result structure (inside an
> existing 4 bytes hole), populating it in the route lookup and using it
> when filling the route get reply.
> 
> Output after the patch:
> 
>  # ip link add name dummy1 up type dummy
>  # ip address add 192.0.2.1/24 dev dummy1
>  # ip route get 192.0.2.2 tos 0xfc
>  192.0.2.2 dev dummy1 src 192.0.2.1 uid 0
>      cache

Reviewed-by: Guillaume Nault <gnault@redhat.com>


