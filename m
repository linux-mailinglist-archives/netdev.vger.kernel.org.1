Return-Path: <netdev+bounces-76425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F4E86DA4B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 04:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034D328708A
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52E94655F;
	Fri,  1 Mar 2024 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qjXaY9vq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1B47F54
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264377; cv=none; b=HPzIEAJ+CBfqR+nHCZfChk7tsBJ/Q83VYN26ylJZ+2ENvlyVozZD8ActQ5UGYEOdPfs7zeb4lDvxfq9d+vFX42EW8G/TrweyhGxjPy2Um22fUBOlQ1TgbuN+wLbB9BFrcnlIJakgJ0DC5lES1naJp1Xj669nRklF7BYrvHHIvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264377; c=relaxed/simple;
	bh=Dmz/DGRvWnv4CEjsyjiUFQiR6kp7ajYMGs2yRdXygqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jP56IuKl33LTz3L0uDl5TZlpI8tlRtWu8ccXi4ljR2FQdqyGpihQekpEzWtDZcE/SsaNfx6pyPiL7ynCBZXPejpsjjZNlbghHj0anPupUW45fsqd6aCE4YS8jWHNlJabFhUtxJ83/5by+vf3etAd2+pcSh7WcrQlGGTyxAIwPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qjXaY9vq; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so1085002b6e.3
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709264375; x=1709869175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnOWlJzPxGoGnQ3YfJQSxaiznXm6JlCSXYm85veUwgk=;
        b=qjXaY9vqWp++NvSEZwUV8r76i4E99cStuMRH1j0OL0GxjCxgzkQHSq7kzGlm3vQxM1
         4ctiU+YAhOZ7ksztyijrSIwEoLgEq0+1rgYZ5rXqpeE7KWsP+IIiLSSnj1NX8aWn+3sE
         w8WDnaVHzH4SLloESUkyv8d7nOwYNRyJDlZdvDZ/FPtvm+3l3IXFVLfAKfA6HsSVHIds
         YyQLeBt34dQaBITixmHaS7Y9VxZYgoOIg8xuRQSxkziPj6IiBXpzYKEBE624bvAuXtvN
         CXNqwfIDHUWnvh99EzTrjYnLt1WQN0ngAY9ezqJn6SjE53WJdVpCKgDW5/bDsJpVo75n
         JEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264375; x=1709869175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnOWlJzPxGoGnQ3YfJQSxaiznXm6JlCSXYm85veUwgk=;
        b=cq5mZyhf0oO+rFH2TeL+Pvr/VbHYGioYJ5XlRUxK3unZp4/HaKFUTZcYYm/wVRBjvF
         +tAHg+ZzEn8OcrM0JD0cJeWl5DDMF92QU6APNUSN7DdOIrQ3majPkepSiihOTa6/YWQc
         pyFSrFLjn4AbMtGzDu2uEcLfrrPT7ifldla3qqbAhtzwLqkQq+C7mN1r76sTg2V/bA8j
         hD9ufrKbo0tNSv/4edj77S8P3wWRXBSlT3Px/aOCz5FX5oCpsCzVkyxlzeA4SZZAj/Z2
         +whUUB34zIueOo2aXn9gbKbjl52F6nmCxe3MpbXosPMSNIwP5t9X7RzfJoUMlqWYji24
         R58Q==
X-Gm-Message-State: AOJu0Yy0tlSSWmKilxM1gRH9mXH/ZXJAHPSPUehiyPqu8Ss5AE6IttzM
	d/0NPFSUYrLrDejsUBhHnAZkkdSVrX3dWKN0x7HvcBHGObE8YYFk4fHWzOylVfk=
X-Google-Smtp-Source: AGHT+IH1aVmaoCG9TpsS5C6gK2yDiyOYj9QhA+Gg9vchJd8DOKXZVqOf3GZyIogpw7LrdsMsMkKNJg==
X-Received: by 2002:a05:6808:1412:b0:3c1:c2cf:87e6 with SMTP id w18-20020a056808141200b003c1c2cf87e6mr724389oiv.6.1709264375022;
        Thu, 29 Feb 2024 19:39:35 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id b29-20020aa78edd000000b006e08da9c29csm963433pfr.54.2024.02.29.19.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 19:39:34 -0800 (PST)
Date: Thu, 29 Feb 2024 19:39:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Tu <witu@nvidia.com>
Cc: <netdev@vger.kernel.org>, <jiri@nvidia.com>, <bodong@nvidia.com>,
 <tariqt@nvidia.com>, <yossiku@nvidia.com>, <kuba@kernel.org>
Subject: Re: [PATCH RFC v2 iproute2-next] devlink: Add eswitch attr option
 for shared descriptors
Message-ID: <20240229193933.38e0bf32@hermes.local>
In-Reply-To: <20240301020214.8122-1-witu@nvidia.com>
References: <20240301020214.8122-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 04:02:14 +0200
William Tu <witu@nvidia.com> wrote:

> +		} else if ((dl_argv_match(dl, "shrdesc-mode")) &&

So devlink has its own match problem.

We stopped allowing new match arguments because they create
ordering conflicts. For example in your new code if "shrdesc" is
passed it matches the mode field.

