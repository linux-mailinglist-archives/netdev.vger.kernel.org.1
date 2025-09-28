Return-Path: <netdev+bounces-226969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8408ABA68D4
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 08:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1D417BBFA
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 06:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2B2550DD;
	Sun, 28 Sep 2025 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP4pDlUU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08DB17C91
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759040351; cv=none; b=MkHSyrqyLdvg20xn9ivjOn93NYMLZcKypIhUJdMgdwtkEUgCyOk+P/MEkpEz27jtqpY7LVCD/x3s+BxNHEDuaJjEPiWOTtUIV/c/Gs9UfjN5tRr95/kWxLrZkPEoficWjtEKvyAh6ysJT5buIO8mRmJBepyW+rJo3a7r5spvBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759040351; c=relaxed/simple;
	bh=FHSh68POuZci0soOBMqYretNIENx6qAcTuhOTMHoj+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT3tWD1lHduBm1vhrtkHpV88osld77Qem8sHxiguFnmmjQq8LWwlrcnX/kMnnFPTHSij/TLY2NyKj9NR5iRNs2DeylzwGliqvL1VXU3kMcEjdsFoSomOOnwshftMpqbMJ7dPu7S1VmHy1kO68jSWhO+P27XVqKWU9EZzLgCEGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP4pDlUU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759040348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FHSh68POuZci0soOBMqYretNIENx6qAcTuhOTMHoj+s=;
	b=VP4pDlUUZMZzNSuvClhZcCENbwTPgnRm/gkvcu0TYPMoui6gib3Z6bZHtbRQVtLi83OyG8
	pkR4eaSi8QhTTqqdm4bm7OUzARrayysJ4Qy7kGQAEFOvnonDNLujpIPFjZR2zl8xzsX+8R
	J7a61DNwYLYGC6d6C6N5ZuvG7shRar0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-aOybh8_UN5yA-9Nbg7LEcg-1; Sun, 28 Sep 2025 02:19:06 -0400
X-MC-Unique: aOybh8_UN5yA-9Nbg7LEcg-1
X-Mimecast-MFC-AGG-ID: aOybh8_UN5yA-9Nbg7LEcg_1759040345
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee13e43dd9so1681959f8f.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 23:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759040345; x=1759645145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHSh68POuZci0soOBMqYretNIENx6qAcTuhOTMHoj+s=;
        b=Hq13bxTemKwk1BGGsIwmv03gy5a9xIW4vJe34y/6LZkoCgW46I2IyZGlDfJOyQEtIQ
         Wv2Zno/hK/YNnVxEdl808Rz16TGhHJblWI0hPcyzYsbKw1gDM157xklQfKgoi+gmejpv
         nFwPZGLn5DAEbohP0Zw3AiHfrA6SS3J5F13yj/dAe21Ju4zC08+VE5XmjXGn1XXMddaA
         04Wq/Alh8oI6dPKZYbfLCV9GAD9IKSThCLrgV54Pt57PqQzgox7I4MKr9YEwgPUIseqK
         Rghp/NkX+Qj7OL9YC9JtAFDQ/mLcnnZL9sFe8cFsxM7a5+KHvRsNf4BF+jYHTwG3WZbd
         WBhQ==
X-Gm-Message-State: AOJu0Yy/hox+9wY47mSuw6txGe3iPaht61EYhsDET5SHEoMjZ0EiEZTU
	563SqpYb1lWd7dktQ9Qb27V3s+2g7vkkEkDYn8+wJ6Qk/fLQr0JnyNz+k1UVYAn0+Ek4xg8ShYy
	xX13323pEl5A3v8pTTXreRFO72LQOpbbRdTWaMI+ooQM4BY1bwjiexsoB0Q==
X-Gm-Gg: ASbGncvFMlxlC0cUWuhvpohVIPondD7XgDY1X0nebf2qMGQ4VEbx5OolfZx2kCrja9a
	QvYO0VWh/VZ4gUJNyEHz9HHXgNdot+cTYjwkl0k9VOUg6xnpDt5wGqjUouSclNaUlVn6eTDj+jj
	rDPy2c3fcEEfWaylvdWuQyDnltTAjww47EswmFp0e1N58kCGe/Qf7rGxV7ER6BFKnkfeUXRkYwo
	nmF+KQxt1c0ip5Kwix5rUy7/Mh5kOrWNaIwr8kR/SmuvqCLbRxdaFC7HRWUTjPktWRtRPfOHVtw
	shy/TnjRgH5UyWDl7y+4sbhEbgUuijw/
X-Received: by 2002:a05:6000:2f87:b0:3e9:2fea:6795 with SMTP id ffacd0b85a97d-40e4b389223mr12613879f8f.53.1759040345051;
        Sat, 27 Sep 2025 23:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGyAlosu7SLyYtGgUxUn7flP3QvS+gTogdl7QE3/POUYAQejBg7RyfeWxq6205Wv9jdzXgeg==
X-Received: by 2002:a05:6000:2f87:b0:3e9:2fea:6795 with SMTP id ffacd0b85a97d-40e4b389223mr12613844f8f.53.1759040344431;
        Sat, 27 Sep 2025 23:19:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:800:cc29:ccef:c1e8:5fd4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fe4237f32sm13263126f8f.63.2025.09.27.23.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 23:19:03 -0700 (PDT)
Date: Sun, 28 Sep 2025 02:19:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 11/11] virtio_net: Add get ethtool flow rules
 ops
Message-ID: <20250928021714-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-12-danielj@nvidia.com>
 <20250925164053-mutt-send-email-mst@kernel.org>
 <4532bc48-ca59-4f04-a3f4-a66d4be4ac1b@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4532bc48-ca59-4f04-a3f4-a66d4be4ac1b@nvidia.com>

On Sat, Sep 27, 2025 at 11:39:28PM -0500, Dan Jurgens wrote:
> As a practical matter I can't imagine a rules within 3 orders of
> magnitude of 2B.

Thinking about malicious devices here - virtio is commonly used with
CoCo. I don't specifically ask to validate everything if bugs are
not exploitable. Just that you keep this usecase in mind.


