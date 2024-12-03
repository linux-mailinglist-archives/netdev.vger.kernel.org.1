Return-Path: <netdev+bounces-148691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B61249E2EB8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FD3B27248
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2BA1F8906;
	Tue,  3 Dec 2024 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP+RMh3R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EF1E47C6
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262540; cv=none; b=OjDydJi4Y1xZjZQoGpZNrqeftH2//Mrb15A/1xLbHRr+K7Hk+ikEwRSMnjBuAYvKDXYF6b4iSuGculXQjtKNZxelZMwjwbTXr6x2V5rVYO6OlbVNFPUBuvIsh69h01ZyjiGn6A86ADG8cIaqQL5XljHqSrZrwERXehanMC5UjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262540; c=relaxed/simple;
	bh=h4V+5q5TBluw2It6xJSGOHN4Ynaw18H7ZqQB22L4n5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sqb+9w7wYGwlvmNxtABgRJOtCCQfiRnnf0lRn4Mf0JRObIzorgwaExPfeFtWLa+J4hoEFnLM0nzV0frhEpeySDIgiUdRO4U61jPkOXewjR3dSG3Sz7lwgTvKW/lLaSShHktSflIvVC9IldlIS4Bhxo/utvpWd9JG1KiGudhGKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gP+RMh3R; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fc41dab8e3so4167336a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733262538; x=1733867338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BpbhjneUazVLWxRBQkKjfh7KR++bWW+kliAF/bP6Lnc=;
        b=gP+RMh3RDNfFbuU6vCYk0Kb2Z9JOb3zBjZwLbMKl8s3G/W8bF2fP/oiPYUVgR2154y
         yf2q7gQn+3FmnZ+9tRfdviGMOZi+kwmrYJe3vYi7LdLbwD2BoU+cJQESPF6gaY/5IcDI
         j0xaUAPKxW50XAYexh7mQpsM/6JfeYX01QNTeYVCI+iXXynsiX8c5aBIq8JlFIpqvXri
         69udesMHG5sgv5qxaSlnnJsGgcd2j0Ma+CgvObdh7P64IuLJXn7Wb5m3/jz/nkoDNmsK
         iu3XGQ8LO6ekaBY2fuS7wNporqaekm1gl2lFt0HRMc6xIgvYWozxjAATqAyUFJ2JOjL7
         kumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262538; x=1733867338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpbhjneUazVLWxRBQkKjfh7KR++bWW+kliAF/bP6Lnc=;
        b=bsCZA1Kb3FRng+9k31aSrYN4OUxp7XKWEyIBfM1IzqjFiM+an9u01zEcEBBfy+sBOf
         Q2bcRqapFbB0+eG+aMPFLTJQuSw9uDBvqkvQaLkVKNE6SG3MSc5Q94l909D/1CD+MxJD
         bSxNq97SLbdeodROSKpJY/NTdviN3aHGoxN2iJAuSjJUhd/aFj20ytYHHXJxw/+BTDcJ
         oKSWX+jTdVi/7rpv9dDmqTWGCqu8ncdaRGSlzbB6TkX9WsBalgyo5V77obbBATKm43z1
         4O7xgGtLGDgPXyO+IT+gztcM2Fq5ucSpe4fmWpa2Ofh3MGbH3HqiFRxLSjxvLA9cNyb6
         hdAg==
X-Forwarded-Encrypted: i=1; AJvYcCVvUokSXpmq6SNNdXbBZEvbHPLF6ahSSE9QaAv6JzUWG4zW+lmZUDh+ewUFAigp/I8VkfQqi0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTwp4g2xGhBMzW/rE29Z15HgL2IzUtuCb4Hh6rTWiRRQ4xCVn
	EikfwUz9X2gYgGzZFHHFCslbeqV/OgNb6J3TFXhVfcxFpKjyH0ct
X-Gm-Gg: ASbGncsNCC9hggwy21B+E1MVslrtnXRJdohOhlVierRgMccpYAxADacKwz9G1b7hsSz
	FWWN+UZB0CkfbohMaquhxkv83YaQTQDO1TsRy16faXiyYi4R9pJ2Z33zqeT/AQU8OUg3S4hSY0k
	lACl5igPB4iYXfByrFgQMHHObWLzq+Amt1w02Ji94Z0xfHR6qrgQq0mTu2UtYuLmTBKsIaXbXjo
	JSuiFGyM8ab4Qgks5Zcw0DeJ5Ktv3CELr0p3vBTM4z14kGzvH2JudBj
X-Google-Smtp-Source: AGHT+IGx8RsmnqZwvciAlDUWPIXGsIXMKfAgZ195Vn7sWLFk0LJkMEdPYiceLcVOmJA7LLgauRWjqg==
X-Received: by 2002:a17:90b:3c4a:b0:2ee:e18b:c1fa with SMTP id 98e67ed59e1d1-2ef0125b2e5mr4616973a91.28.1733262537960;
        Tue, 03 Dec 2024 13:48:57 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:eba0:9698:d316:6990])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27033462sm35609a91.27.2024.12.03.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:48:57 -0800 (PST)
Date: Tue, 3 Dec 2024 13:48:56 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Frederik Deweerdt <deweerdt.lkml@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] splice: do not checksum AF_UNIX sockets
Message-ID: <Z098yHlrNYJsdzhM@pop-os.localdomain>
References: <Z0pMLtmaGPPSR3Ea@xiberoa>
 <537172.1733243422@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537172.1733243422@warthog.procyon.org.uk>

On Tue, Dec 03, 2024 at 04:30:22PM +0000, David Howells wrote:
> Frederik Deweerdt <deweerdt.lkml@gmail.com> wrote:
> 
> > -			if (skb->ip_summed == CHECKSUM_NONE)
> > +			if (skb->ip_summed == CHECKSUM_NONE && skb->sk->sk_family != AF_UNIX)
> >  				skb_splice_csum_page(skb, page, off, part);
> 
> Should AF_UNIX set some other CHECKSUM_* constant indicating that the checksum
> is unnecessary?
> 

It already means unnecessary on TX path:

 * - %CHECKSUM_NONE
 *
 *   The skb was already checksummed by the protocol, or a checksum is not
 *   required.

Thanks.

