Return-Path: <netdev+bounces-240424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D9C74BAE
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 332E64E4835
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7833EB11;
	Thu, 20 Nov 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Wv0H1UzQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99B33A6F9
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650521; cv=none; b=jI+16/uS1KO5mJlq54ntcOoDFL7sUj0F9bmYg6F2Hnh2Pps7X2uyuKK9KTBal18Z77c6R4KLS3DZUrMKhzTSdwtyNVJcb/hUvYfu/8J27iJGQlrHn/YEX6hTqtlR7Xnr9xSFc8SJlXcdRUKHzXIxFIljuCvrUMX0Lr466nUiTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650521; c=relaxed/simple;
	bh=IYKfCs3i0v02S1nziPd8Oz7+F3sngphV+VccYH5t6I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVRZ8yg9iTP5rqi2Y8d4ZixfaGc8Xzg1ZZgpBeIqu8m6TpMCH5vLAB58l3kd3PyVagzh3bAQbrK3jKA0SaKvEOeRG5Mg8Ex/rIhEY0xC4zksSlN5G5UlVDz41IHeccWTT7IPfwo/mrwPzw1xTEienetMCgeix5mSlvfZ+/+MRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Wv0H1UzQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b71397df721so182843666b.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763650518; x=1764255318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYKfCs3i0v02S1nziPd8Oz7+F3sngphV+VccYH5t6I0=;
        b=Wv0H1UzQWEoKiXKbq6WEYoPYNnT3wIK0V/RgJjk7Jb7/YDPKZ02ZItAUh9ek682lkF
         J5zYk2oOz1JthW0BaAsKd/5awaatlRy4qKk08lWbHKzH+AkwNj9cCWCzcWUuFnX8uZJg
         wqJFMDc1He9WfqW0+oq644ini3fMEHCgi7xtauUYbqVcluvPVwi61GlrRc720TvGuoMF
         1FefV2wJLVmSml06m0OMBuEYeUytqJfZmIydHw3wOhIprcBXwgVYlqIS0zLrFs7DDiZC
         i0MU88S7CTxi72tpgAtTuOFNaAwMuOSG1EAxF/ko1RNuQY4hyLfHjzMo0GyXh4Ptity/
         wfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650518; x=1764255318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYKfCs3i0v02S1nziPd8Oz7+F3sngphV+VccYH5t6I0=;
        b=hgHeDEBYw7C4hr9KXy6muOqwxS9muHQRkWmiABsneUe+gnwVKi3AT9KQZZoYKnAna3
         Jrj43MC629KpMN8s0zpC6mjP9Nl7tlonBNoYvMeUu6lXFOHLmVjMfhqvW/N36pgnLDIQ
         FwMyJ1zxfTjPn4W9EaG+U3NUo2Jt2PqQzvQhb+fT00MsCTr7rMQLk6MwHWLcXedHm9O/
         HBduBaNDpUvOatXh+a90UlJOJYC1JxNIziHn5zn+guoc4x8aZyp26MvyGnWRU1gli0mU
         fFxXR9PdJpviSFgR9+JvkPXgpaDhZ2lml22e2+FTEG3mKwVcnZJ8VJO4QK5kYqyu7mvt
         Otpg==
X-Forwarded-Encrypted: i=1; AJvYcCXV7FUEZo1ZTucFEl2nwKfjx2I2hxV42ZyANRL/oKnbPMvWf1Mak65M/zGYJh6mX8vncZjtdm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx590xiS/OYjhyUf7ynuQMIrEYq6QtvWMwLq3ML5kVbed/4sv+w
	MReA/orwYmgs3yNv1Kqb7bclrOKtDXQFfIoGxReMGmqBpr1W7rJotdN5QrhBt/VsQUU=
X-Gm-Gg: ASbGncvWU2phZsXXYldhRm3lfzXoNgT0CggEQnpoy467r+zZmu+KGx6G84la1VvqSHe
	5CVyOFl+6i7mQe4Eh+5+QkZxeidcLVE8L9/W98ueJzdHZlMzIvIuSnYyIjhVpeqs8UW7VoVcAda
	qQfWF2Vd8WMOirDvNxA91CWpM4E3X7xgoCcY+517UJMPkw6RX1bGnP7sOzM/+WUkkalyXt4X2qB
	zeGyire26eFLN9n/gv4nnIE6YAD9WxVC0DP+dbfrZp74DsUDGqhiRx2IEhJcy8bkMsee62bGhXW
	4BrLIfK0Ta3X6lCYj7ZSE+foqkPrHMWfrxqshBmLqqF66ceRQrXpixx+aTY0xCUmcI6sV/cTs+U
	0w965lRoLbR7lEL81zd/02nZrlcX9Q7v2NOAxOBMPI8hUiRTHgsN7iSqFK2rat4HmX+eZOyC2js
	QPuppst/kibr2MJ4c+bsw=
X-Google-Smtp-Source: AGHT+IEPtM6EIIGo4193tVNdZEj2yltOmNHgf2oexFbhFB6uocPPBppvPF2J67DDaWgxEDBcuxOxZw==
X-Received: by 2002:a17:907:3f1f:b0:b73:6534:5984 with SMTP id a640c23a62f3a-b7654dd66d1mr355087566b.16.1763650518326;
        Thu, 20 Nov 2025 06:55:18 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4f59sm217338366b.36.2025.11.20.06.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:55:17 -0800 (PST)
Date: Thu, 20 Nov 2025 15:55:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 05/14] devlink: Decouple rate storage from
 associated devlink object
Message-ID: <3yvpa2ni6sq5wymlvesp3xdoigc4dlvhbtrixz465mr3k6y7hw@buvno7yetqma>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
 <1763644166-1250608-6-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763644166-1250608-6-git-send-email-tariqt@nvidia.com>

Thu, Nov 20, 2025 at 02:09:17PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>Devlink rate leafs and nodes were stored in their respective devlink
>objects pointed to by devlink_rate->devlink.
>
>This patch removes that association by introducing the concept of
>'rate node devlink', which is where all rates that could link to each
>other are stored. For now this is the same as devlink_rate->devlink.
>
>After this patch, the devlink rates stored in this devlink instance
>could potentially be from multiple other devlink instances. So all rate
>node manipulation code was updated to:
>- correctly compare the actual devlink object during iteration.
>- maybe acquire additional locks (noop for now).
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

