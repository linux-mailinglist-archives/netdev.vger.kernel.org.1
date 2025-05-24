Return-Path: <netdev+bounces-193225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A84CAC2FEA
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 15:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0D97B3B33
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973821C5D53;
	Sat, 24 May 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD7mLEYc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417910FD
	for <netdev@vger.kernel.org>; Sat, 24 May 2025 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748094478; cv=none; b=CAsmr/ID9P2o0cJJ/H1ETv9Gl70hhXCBDKjWqObCWL7y24wh1SEH94NkLek8WgdMQ1qI6t9T3MRX5p/mE+vfJv7oxW/RXWZrEqI2wxrjNLkVXL7Fi0KBbxDjlXDKg/sSS8jvyeM/Mg3kn0ln72bBOuG7gwzGlmHVTNdofj+J2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748094478; c=relaxed/simple;
	bh=dsWq56KljVv1Bb0P0pCoCxbGb6MWgKfV5pdM937PqHY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hf80H9Ks44eIVhATckzE9Fne6st8Ua03/tsju5iIfkdaUQPgGNM3j9R3LvVK3X+10oAgyTIk3OUfDuZFRRtjY1S55MA5hBfIkrH4XnUj9Ue5zw68jNUJxE2jm55MlYvuQwB5XGCbXr4VHgZCw6wRgwXxVQ1nWPuKJ92vCVYF6sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD7mLEYc; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f8c3db8709so9104986d6.0
        for <netdev@vger.kernel.org>; Sat, 24 May 2025 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748094475; x=1748699275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISM76n2Tnbqm5Bl3hfkRDKPNfioiCB7kuqIwIHhyVnw=;
        b=QD7mLEYcEblF6zXaMscEUqG4qG9im5BTOQW61IAbYGLnenTmyKgoofIM8bBV1EZdXR
         Yn3m2a1Gh6WNxncpLKYPJE54vEwASasZLJbRlU3EGqdczrNCaifElHA4QSJaPXBmi62M
         uwr5qXfRANFjZgjycRJLbX4zZv89/AIYuMBUjwmFVz4r0BKW5BD1L165VExmvbYmfo2U
         wofrcNIU42A6atyIbeeJhdCwNO5wD+ILNXQ5dCmDHzb9QyeuPCnZ2RVjuBpzg9dz12kt
         ksdRo3h4rM7UD/deIQygJQg93/ejHHEFNK93nbUqUv0qfmf4hu0qTPMb82XWQdZh/30g
         S4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748094475; x=1748699275;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ISM76n2Tnbqm5Bl3hfkRDKPNfioiCB7kuqIwIHhyVnw=;
        b=uwsp4DAYM1w4I/b7Nd/2wZYV/SuxY4qlbLo7fLvmrcAoXGRYhcrFng9k/4aSnPF58m
         3YDQP6GuBMCuVe6p0xxuQv0t5WEIIOcCVFAg/Fy1fNqq30Jkdlyehii0hoOB3hkcsZGh
         fVaZTMhySZRsvwbjMsMuyHvzhd3NXuvQYW3dznXAuR1yGhMjZYj+Fz/BrU+IZhtLreTn
         KIdNQqXO4sYaJUxKeTO1pZdUei6yhMHQ20RZJJyP0UcVmefXoCrkggjPSy96AXLqesps
         lUSZ+k3rzZxyGulN80OTcqFRbx139DzHjhYacYVoexj6IdNjmGl3hI/kl8oPOhgfuhyO
         XfiA==
X-Gm-Message-State: AOJu0YyehlHsLLvkX4IS2/RxHlTvfJkNj7/qhne7L+hBVWSwoN9wDqE0
	zLsQLfTXnabOKUnERNia/lPounwPWwCRHgBA9DFlVpuoA8YiVjTWBiQIoeV6jQ==
X-Gm-Gg: ASbGncuKpgvKwhsU4V69eSVraxTxZ/jBosoPWyoR5K+EXJQ7X7ZGK7i4Iw+Fsa2tDME
	8cWGx36J++ChA2Pi7eKFYgOP2yVz7vD5aVYA1/DAYPQGX3WJ9oSMQO41AEsQrKB95xbKUtpByKL
	bdjSJsrh16viFAvLsqx/7yIL1qfijv/wPtkER0ODzG1wTzaS3/mqND+qSEbVCqtNqmCTh8Ly7yC
	5JqUspcg6wZmOOK4hnhh2z/qAouUiKyyEG6s3XvHeWIQHZ5jP5Hk2r1cEDMOLQETxlDOJDwQYPu
	U8f4o2d5Lugg2x+U5TEgjkuXohQhxha8g4Z7vWQbxgAlQRJuYB4rQzIHniYxq5bsP12RDUMDQuc
	9Doh6qqMVlw4ZMOMGTg9PRfI=
X-Google-Smtp-Source: AGHT+IF3yKcNUptcEJ2IBM88L6dQo/bzp2ojudQjSU+U7OFkoAwjgHK57u72T9CL3rhZx0AnifIdng==
X-Received: by 2002:ad4:5f0f:0:b0:6f5:438f:f4bc with SMTP id 6a1803df08f44-6fa9d13e70bmr47229666d6.7.1748094475606;
        Sat, 24 May 2025 06:47:55 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0966159sm129281766d6.81.2025.05.24.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 06:47:54 -0700 (PDT)
Date: Sat, 24 May 2025 09:47:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>
Message-ID: <6831ce0a338c3_1e3c7c29496@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250523155853.14625-1-milena.olech@intel.com>
References: <20250523155853.14625-1-milena.olech@intel.com>
Subject: Re: [PATCH iwl-next] idpf: add cross timestamping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> Add cross timestamp support through virtchnl mailbox messages and directly,
> through PCIe BAR registers. Cross timestamping assumes that both system
> time and device clock time values are cached simultaneously, what is
> triggered by HW. Feature is enabled for both ARM and x86 archs.
> 
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Reviewed-by: Karol Kolacinski <karol.kolacinski@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

