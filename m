Return-Path: <netdev+bounces-239838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77688C6CF70
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3332C35B1B8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00553164C3;
	Wed, 19 Nov 2025 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yzo3SarO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rEvVWtRY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1B318133
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763534407; cv=none; b=SDhEYFoTnH7JPXjIxZKtk1vrkIRa3PvFGEbmjPTDR4g8MkNxRA23xQpDmVazc/Qeio9JouLqPaEAfQ9Udy0Sxy1nrzq2umgShO0H9UZl6Z2tgmFqTT+1AgCQEw8bMu+mqL/xyndAKrqBMctpmrCglfefB18OLZqsqJpnc78er5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763534407; c=relaxed/simple;
	bh=S0bW8FEPYvxlNlsBKwHlG1/2rcNkECm3MSq3Fk1VY0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYkPkXY/sDT7pR1sj+NAC3rDzUB0Y8qtgTUJdiMW7o5Vtc7ZY/mkKFj5e77frsOHve7sI3izfddblU505P/XlQ5ESS4NYeB8vS8/YxIowyPURGZdw4vTuFqR9/UKQTacWxLyIcE5m5TgW30IgoLFdAUq0oXpuldo8HZHsd9GZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yzo3SarO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rEvVWtRY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763534404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SKnjgl0kQ3X28J8QCPC2uba5bbT39T896MHGKvSIyu4=;
	b=Yzo3SarOmFCHadyUbeItL8HkaEGobBbudW2J15DBMV09Y5CuVCjKzO45ESulRbJEUgplZC
	Fny+cEkfEf3x4gQpQAOeF7gecQ/lcHbv6ZVAEaaj8/E3V2+E/5EWy7POxkSOXSOE3ZGI14
	IM/Sw0B6Wlk6yhcFupnHYHQ1aorDdu0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-mtJZ8mIqNWSi9uqG9cikrQ-1; Wed, 19 Nov 2025 01:40:03 -0500
X-MC-Unique: mtJZ8mIqNWSi9uqG9cikrQ-1
X-Mimecast-MFC-AGG-ID: mtJZ8mIqNWSi9uqG9cikrQ_1763534402
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477964c22e0so3963865e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763534401; x=1764139201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKnjgl0kQ3X28J8QCPC2uba5bbT39T896MHGKvSIyu4=;
        b=rEvVWtRY/nwOK2Apg5AoeaOyLwLQ7f35Xqv5BjEGPqgLibB1oOsxmhpSlrRVdLa4Ol
         vWWKWim/BRuQxCnRRSU1earck7+dMXG25ASfT5puTUoHuxdHSdmC6uyWjpeAFasaDvbZ
         1nfnv/u5oduCVt4ka+Kcxfs0/CjpWPl7Qz3QATzi7Q4nBXVCeoMk3QwIdpDqbc7uw6b8
         lM3zFLGwLEJSWGktQQtIIExTSNSa4QWFT9gvOqxzEoVxEhYDsYHeehYUnV2OTBnj1Fpf
         FvzdkYm1hGQ0e4K4D7AZ101SrBl2YjHaIrcl67R7S+W/mTTGl29CkIKwbYuK4yoLfePP
         qZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763534401; x=1764139201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKnjgl0kQ3X28J8QCPC2uba5bbT39T896MHGKvSIyu4=;
        b=BqUhKmNlqiEvxchqmaJEZQIH4PFBror5frI99YI/kLfo0Ej9dgu2mcaukya9fMQVFL
         29QEEYRVaa6CfwcvctHkqG5fiMNjKjDmxntChWmVBhxWl9H9hZU1qLlo7GmJ8ah7dxvb
         +VObgeOOlRfLkKA6x2xrp7HMuHCaA2HS+3OXkEUAbt726gJF7AiQMLnf9zWAljwnDQpr
         JJCrDcO1piYBT6GoNzk7cGEpj2VqIdF1LaX7aE8Srie2IenTweSG1l4Q6iRrUYGBzsrS
         aVvWbX5K/wIgrUzx9vPDPQJPqZi5K1CGF+ATOp4BZvJqOGvayRLfQmXp14Y2xJTpUJ5v
         Mqng==
X-Gm-Message-State: AOJu0YxBIzxR2D5CEeIS3WH6Kvo66UdH6tAtD9KZVPUxT2erf15pgIuM
	meuAhV+0BTb8V0lEvid3SG2tqDHYxrvId3yQA44O7G4ZRSFIYl7WIe3ipo7cq9jOLnOeZifNGdG
	ddqs+1PZS4n+cvYriIYF9EAoHENvpjDhX90CBoN0namfbXZ4RP2/cTCu/L/VgwqeBCQ==
X-Gm-Gg: ASbGncszD3YwwJiF6WGmBmtazQ+0P1seLlYTP7HA6iTt+/NKB8AtXXLk0D3OT7NihTP
	Xe24s7292NKn2oNh+7z/tkWOMMEJsAR6S7dlkGskcwrXkDyrRtyP7Y/+bOaDAn052O6CFvOQg6H
	cnV29FoiVjBZRF3S7H9KnyDwxx7q0WF7m9K4TFEHkRAJYyNUXbV04G19GN8D84xS0cWDOxFTmzx
	JBUL4CKB5QZC85GrtEmizwxNX7cvpKZorB2SG8pT1c+FO6r+r+iefYT94p7A/yFNcEYu07QKfk6
	bXq1RezPu8erRnE65iwg2Mp+xBjtQfp6OrJ4pH07nPaht5gqiSA9runEg+sRJJ2Sla7XZWiY26P
	eDlLs8RxP/gx5v8ADM5NbT1Js0RuoGw==
X-Received: by 2002:a05:600c:8b68:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-477b183de88mr10279705e9.16.1763534401422;
        Tue, 18 Nov 2025 22:40:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6cgNTBzLQsKkNSEyu3gdScRsnvnotpgfJecg1XHhy1j5bwsjTM6/EQU5MJrcP/FLL4rGe1w==
X-Received: by 2002:a05:600c:8b68:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-477b183de88mr10279415e9.16.1763534400983;
        Tue, 18 Nov 2025 22:40:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10173a3sm29151075e9.5.2025.11.18.22.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:40:00 -0800 (PST)
Date: Wed, 19 Nov 2025 01:39:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 04/12] virtio: Expose object create and
 destroy API
Message-ID: <20251119013550-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-5-danielj@nvidia.com>
 <20251118171338-mutt-send-email-mst@kernel.org>
 <e5641fe1-e1a7-4f3f-b4d0-1dde55e47c83@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5641fe1-e1a7-4f3f-b4d0-1dde55e47c83@nvidia.com>

On Tue, Nov 18, 2025 at 09:29:05PM -0600, Dan Jurgens wrote:
> On 11/18/25 4:14 PM, Michael S. Tsirkin wrote:
> > On Tue, Nov 18, 2025 at 08:38:54AM -0600, Daniel Jurgens wrote:
> 
> >> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
> >> +			     u16 obj_type,
> >> +			     u32 obj_id,
> >> +			     u16 group_type,
> >> +			     u64 group_member_id)
> > 
> > what's the point of making it int when none of the callers
> > check the return type?
> > 
> 
> It's an API, and return codes are available. I don't have a use for them
> in this series but perhaps a future user will.

For starters let's address the existing use which wants it to never fail.
I would say do something with an error inside the function.
Maybe just WARN_ON_ONCE.



-- 
MST


