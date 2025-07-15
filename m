Return-Path: <netdev+bounces-207242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD938B0655C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1D16F88C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1A277813;
	Tue, 15 Jul 2025 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/yZsNJW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81520408A
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601702; cv=none; b=EHWvujRv3VASNBzWYguefx58zapywzZ6npXHn606CSZa8I5y3ViZrX+rQI2Lm99k+w7udTZWuBUPDgZwwn4bXThGESexJWDtgB9F6wfm+u7/0ng3ZcmYb87xX6A1gl3yoGVPdLTL3I1jxmv2ElrHnDEcZupexiRXSu9bH1DpV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601702; c=relaxed/simple;
	bh=ekG7rYzd0m+fZC32LPMrbO2fvfMOtPpd7gZMe04kX7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF1FyWi8vUPJtVmpLtOEFDX3v029ALkxOF2roSUXxFZB7cO4HVF7p2xbo943iH7z3hqeEKSfKDoCyrkGUb8ar7jC6aXK/d6uu1EC0wD06vLvdCJ7jUBL/bvzz7O4M2fyuQej2SyOPMy+J9FerPZPBsJ16b5yZNsylsiM51Z44fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/yZsNJW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234bfe37cccso48067705ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752601700; x=1753206500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDI79tvLj/osfmJQyvQQWmAbmSXgXNIPvEnX8iJFms8=;
        b=e/yZsNJW2eJ5RWAJMBQwz6hZy+Nu5n20ZFMs8MhVlNujRigdscCh5T6rKIwrDZylAx
         R5diNqAdXDOpFA1kAM00MCu/ujSyV56ZM7YI5gphz21+MYbaBzbjzIoNl7tSceLRPn2H
         gkpdYRf2XDFOSn0zfniq77wRi0iuoqjFk3xUys0uUQZMeP/3IAKDTAMgP1t2gC+Yrv1R
         4b0mQCpNEsNVDLy/PS8QXBH3KMWBcd6xSsWuIEpMu2E5TqEoifyhbVqx5itLWhyif+zD
         LOgGpDlKe3LPC911F8JqWGf+G70BthHaUzUNUUsrtD19ys4pUCBSERe0VUX9IH1UkPZJ
         Zx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752601700; x=1753206500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDI79tvLj/osfmJQyvQQWmAbmSXgXNIPvEnX8iJFms8=;
        b=ZN4vnZ4C7oj3g3Hqx8Lb3gYxk0Y/GeilwR3evkPIdvSLnoe5tNQfVIZkcTOM+df9N3
         j2FjvH++ogev5Q0Ic3YEEAoLuw89pIVsCphTjRqDB9BcZk0AACfuCSztQ3TKpk6ChVEJ
         UtRSB/rTp8Ze3wFAvS2StAek3hSXwa4mxrL0ngklod1iCNlrS61PSkurLdKtoTuMHOsb
         bQG4j/PsKr23C3r5X215rhXF1WMhhM86mgy5WgDuNvHYj2ZdVq+zxo9wAEpiJnbFCRTm
         2D+OO+iVLE4btKP/bf4QWnLJscuVPVCOhQB3bg+2BbfSsjyeff5SHhjnrw4u1LbDf1uz
         avDA==
X-Gm-Message-State: AOJu0YxCsTEJ0lhJoOUVgjIJ0BbSM5mHacjo3+OiyvIwMqPfRwNo1HGG
	9+8anu9c8SIEivZT6XP4AbTDBBqM9yVL6MgJLaMPSWNXrZztg91Kk+PIHAexIw==
X-Gm-Gg: ASbGncuFmBo5GlXVBoqDZAmrqzP89NoMGpvYGRhrzVxPWS0tFg+hzw9enP3W9rkYGho
	w0I5gH+wzfyssWcUzoDnoDfpojPssXuJ7820ry9kCDFVRi5B1kMuNFhbz0BmTlA16q4JZAllu5W
	1ZqtNMYYEatQBMu4OcVSqOyKEEwM9At6zbYJ2a1SkjEH2e5TVLTyp3p7Q5tJGVd6cA0S3e02Vri
	BxYwEo6Dz6pBPE+4dmBi/+rtmlBZY8X7BD43VszMQ3qcnfz9tITeDYRvojNtba26d4TWCZ7n/Ew
	gQTCg3Qx1DHf6rOMzhW7gse2F7N7/Kjf99uhlsTPVwOIhzgQUh6J5xTey80oYyVhHuLrp37dlfE
	7DbPIRIzegNkY11//q6RNy3+g7Q==
X-Google-Smtp-Source: AGHT+IHM3DbTHR2Ga7CjQRHBdtbdtmE/4QaqSbZMQmUt1p/dEeZLa20oy4G2An7SHs8UEAlOiYHNyQ==
X-Received: by 2002:a17:903:3db5:b0:235:129e:f640 with SMTP id d9443c01a7336-23dede924camr218156285ad.38.1752601699512;
        Tue, 15 Jul 2025 10:48:19 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322885sm112083205ad.101.2025.07.15.10.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:48:18 -0700 (PDT)
Date: Tue, 15 Jul 2025 10:48:18 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, will@willsroot.io,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch v3 net 1/4] net_sched: Implement the right netem
 duplication behavior
Message-ID: <aHaUYnIZjHRItYu0@pop-os.localdomain>
References: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
 <20250713214748.1377876-2-xiyou.wangcong@gmail.com>
 <20250713151220.772882ab@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713151220.772882ab@hermes.local>

On Sun, Jul 13, 2025 at 03:12:20PM -0700, Stephen Hemminger wrote:
> On Sun, 13 Jul 2025 14:47:45 -0700
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > +	if (q->duplicate) {
> > +		bool dup = true;
> > +
> > +		if (netem_skb_cb(skb)->duplicate) {
> > +			netem_skb_cb(skb)->duplicate = 0;
> > +			dup = false;
> > +		}
> > +		if (dup && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
> > +			++count;
> > +	}
> 
> Doesn't look ideal.
> 
> Why do yo need the temporary variable here?

It is all because we need to clear the duplicate bit.

> And you risk having bug where first duplicate sets the flag then second clears it
> and a third layer would do duplicate and reset it.

I am not sure I follow you here. After this patch, we only enqueue the
duplicate skb to the same qdisc and this skb's duplicate bit gets
immediately cleared here. They have no chance to traverse to other qdisc
before clearing this bit. This is actually why it is safe to use
netem_skb_cb() now (instead of skb ext or tc_skb_cb). Or am I missing anything?

If you have a specific setup you suspect this may break, please share it
with me and I am happy to test and integrate into TDC.

Thanks for your review!

