Return-Path: <netdev+bounces-160199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390E9A18CAC
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8CE188CBBC
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 07:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643261C2DB4;
	Wed, 22 Jan 2025 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsVgJLYM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081B1C1F22
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737530302; cv=none; b=Mw5/e8AAkA6QzZO0XdIbqrfLzwZ4BZ0555BkCup3mYBDiCHP85nfpqgIR/ApRVHIPaKfWil3/ykL2pPg0PGwlpzw8+oRyuMk2KkoLXFmeDCqUI7/FXXwrrnz93U692GFSHEQR14YMW+dKQPeEGeFEfPpnaTK7ymC4K0zPjzvYqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737530302; c=relaxed/simple;
	bh=YEGflwjghorvVYU5vOk121ZOciaycJ1sBGE8jPcq2T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j62NZEtgeweD2QSiOwgku7v7aTTnW4OcQAB3YlxH44M2bXTlP+G2WIguSjvltQa2jt6ncugCPiQIcO5oWJtFjSLtQQAsq7vu0teUsZJjGWvclVetVIaKyIariooDHV1QvUGxxMuwcPLYFbsemolDVNXpzuwpkGHQ2vg7vOFP3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsVgJLYM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737530298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEGflwjghorvVYU5vOk121ZOciaycJ1sBGE8jPcq2T4=;
	b=FsVgJLYMitcdX2Jz2jgZATQ2gNLDQyiEd2pYZAvz0VPp0Slg2KjBNjVj1800GRXCkSaTDG
	2TaO2mPwyuk6HIv3gs1rWSl8BQVANkjgWEUdkPbk5zzIiDLTqaLXnUiSA3O+fyFk8hhoz4
	YErj1Td8EnAf0nabKmyabDJIYvuXbvc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-MfWjhMcINliOYnnWbt30JA-1; Wed, 22 Jan 2025 02:18:14 -0500
X-MC-Unique: MfWjhMcINliOYnnWbt30JA-1
X-Mimecast-MFC-AGG-ID: MfWjhMcINliOYnnWbt30JA
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3ce91c403so8781938a12.3
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 23:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737530293; x=1738135093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEGflwjghorvVYU5vOk121ZOciaycJ1sBGE8jPcq2T4=;
        b=EIYPjJ/OlO8TMej/8sEbFi66Y5uOtsDtKHm23W3QMdIMOaODRabCxJtVf3eLIneDhE
         FPgSjGGp8Jz8oeG+uJeJYrfqYq1MZZG9LxqwE8JGnJmIphtmu5hZNPjrpXlCu9e4dNKq
         ZJkPoHCrpswCbztRlU6vhlfnPvOwTdmi5IRr4obWCqWx0Yxld7TeMcMDNStYjdYqS6+a
         Ol5zSuLH/se3DnMeZghIsIxXcyu9rI8iiY/MMpbZ8Ajk+G1Gb5UnEmJScE6DtkwKacJ9
         Y4SWgBHFmyZFIeY7VCwYcEq1c3Mwl9Ecwqs4fIfobDYROuF78AuOuzyFpF5BoCoeLTgR
         E5eA==
X-Forwarded-Encrypted: i=1; AJvYcCXmCXsD4VxnP2IYKR5ieQaBANZbP6879HBv2YUDRAPG9ItPXN9+2AhU+J+FcnRl9XaQrJm/gi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGi74v1CVorVia+R09BPjlfJ9bjZmqKb1j4xabFo0PEXCcNOI7
	H4P/PCcq9XEFusKigDE9Gh8RNY+i49xudTN9tQAnUckEuxN+RMLcPCWn0dp+UJHL4Eo5gBIdWg2
	owU62+aqwrW+YgjflBY7k5uwXy3PKsfTD7AnUjBU3Yuc5bmQTy8YD7w==
X-Gm-Gg: ASbGncsvCaRYAV6wJBwKrvs6jhjuerIhNEKqXugjVwokda2JTOK4g/hr5qjJK9MS8ce
	A/9wbgRUl+cF3bcmZYhEH6GQOqUPL2G5Ru9Jpd1MmnCa+VoXIFdkzVaZDAwEWRJRaio7EAayKeJ
	B6Sy4eGHhy7cHjaMzP7KhITbKewSDcvtMQQTzZYRwsN6uYYhWOhiW7S5zeppcaun5rUiBiXraXq
	RSFL+6zzv1wOWoEOMr77sBWreh3JZcxQuOTSOzZQs5uTT3MxZWhmfAUbdkdtxiRYQ==
X-Received: by 2002:a05:6402:350b:b0:5d9:f362:1678 with SMTP id 4fb4d7f45d1cf-5db7d827306mr18359487a12.23.1737530293307;
        Tue, 21 Jan 2025 23:18:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyqRjQyumBjYcUQXfl81qk1Ssy2hqd/dBbWDlwe25OUNiHUGvNrn7xmiKDctNp/BPDMN7QhA==
X-Received: by 2002:a05:6402:350b:b0:5d9:f362:1678 with SMTP id 4fb4d7f45d1cf-5db7d827306mr18359479a12.23.1737530292977;
        Tue, 21 Jan 2025 23:18:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73642509sm8016880a12.10.2025.01.21.23.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 23:18:12 -0800 (PST)
Date: Wed, 22 Jan 2025 02:18:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
Message-ID: <20250122021720-mutt-send-email-mst@kernel.org>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-8-lulu@redhat.com>
 <20250108071107-mutt-send-email-mst@kernel.org>
 <CACLfguUffb-kTZgUoBnJAJxhpxh-xq8xBM-Hv5CZeWzDoha6tA@mail.gmail.com>
 <CACGkMEsDjFgyFFxz9Gdi2dFbk+JHP6cr7e1xGnLYuPBce-aLHw@mail.gmail.com>
 <CACLfguVoJP-yruzy-6UVb2SBD_hv-4aF-kBU0oLAooi8X56E7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACLfguVoJP-yruzy-6UVb2SBD_hv-4aF-kBU0oLAooi8X56E7Q@mail.gmail.com>

On Wed, Jan 22, 2025 at 10:07:19AM +0800, Cindy Lu wrote:
> Ping for review, Hi MST and Jason, do you have any comments on this?
> Thanks
> Cindy


I see there are unaddressed comments by Jason and Stefano.


