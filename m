Return-Path: <netdev+bounces-147615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CE99DAAE1
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0669B20B2F
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E43E1FCFD7;
	Wed, 27 Nov 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmwn6BEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13618FDD0
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721650; cv=none; b=hwdLjiL7Nb3PwlgAl2xFKsiC3UwZ5OLmnw1N+vLje+a4TjDZBvh3Ej40Qzy7132NsOpMk9Nck5v+TrSiRHduCpA5PCXIy30aVymM7bp47sRvD+ye3qqXNZxSDjnpYjlfIomy82e3rYyOGEc77zHFPqmn7fyfLPcnuq5CFy8ZGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721650; c=relaxed/simple;
	bh=4Q+79t4Ehjz4uhTJ2PTguamvLBPg3IWGClJcxn8TUrA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UnI7bp3VwaQslXm6LVL9TZYjCLqhwoSTBkIc18fekTKrGlxtjY0Mod2DpFsi0wVXgc65ufuLq6aQArfvYM/LCzjxCRmgbvwBtsv/0r4cHVMnqqDflHsWCPMfMkERFdp8LrQxVsrRruIU3WsOZFNrAZZPzDAnvajpJVbxBrra8E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmwn6BEE; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d41dbf6cfbso52598476d6.3
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732721648; x=1733326448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehLBCZMvqNM9RzwEXeNAalHuQSt29OG4XkC9vSde//s=;
        b=Gmwn6BEEGLcI24JQRLjvskzJSzUfwgpTGMKySV7zjbSte3BxIm1xdcufNvykli1l5X
         F11AK8VhqUdmpE/TYeuSJYEnLiMl0+5P692Vd6ZkOP+9OVKqVJZrE8uBHE7CkAY1xDNT
         g9TahUfVevkH8oarSWPrNvoNkyx3H7hXq1k1/eECgzpUk0UnaUChQdL8xA0Nr1rwlndw
         Yfeirusjuk4Ny6GQsrOz9F5CSAr7b/xpbz8iwNv96B7JtXFVsWHUmXvTwdf1ZEs5rWhD
         WL5S2JYS6zxYS+bsxD/NHe9Cu5wWLVfQ9W6MOzHOS+isMKT9tjZbL02UPKt0eW/JCPnP
         VQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732721648; x=1733326448;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ehLBCZMvqNM9RzwEXeNAalHuQSt29OG4XkC9vSde//s=;
        b=neOt0yzYyNMJ5dl/k6D5S0BLUWj1dAM8oS3qXNrDvYGR5CZIum5O+Y9WCynARXvgms
         RnSWzrsIYF5wHwIVk7WVQsgvC2BEZeKqsH7MUyM+Qsh/+rAGSID1+rzXrUMa9FeRooYx
         AHN5+0nV3Cakj48vN/90Y0kLokU3UJbxuyQjE3JbPRD+CefS3dOd+6N/ECsDKQdPMs8f
         CiaMSFJhQ5fOrd4IacI5xQjliKxXgwBfTYyfa446gPEeTD94hIc2Jmu1kYuaQDVKAiLW
         yN7iQq3+pEjoYPtYfMw08zRws6uEnAwvyFPClDkzTqIZa9gND5loJCZV1ZRjB9TBaB2L
         +Krg==
X-Gm-Message-State: AOJu0YwolI0r6803p+Xk5+WFG8dBYgbr9jELhfjfiRAOzzzcMs8ZDcVR
	XeMraaZNZEpumlS/YVDRIzTeb07Fq75SAGXUPixsO+zScgatoGuD
X-Gm-Gg: ASbGnctGQGj/mqPfT+8Z4fNPcZaS5CBXGtxjEebL9Nsjfep64ahp+ftmEDbzbvEYMUa
	UP0W4XuITkSY+PByt3/hA1eBH5wJkzVnwmkWmiNVU2XEMwfIgoA7DF/JCSbwJcZCQ8tXF5a3KJ4
	l0z7JPU5Ig99P3XLBv25kuM1FEx19ag5r+fijVKyYIOIWEY9M0U8L7ueQuu9mlThKGwBK2G5X8P
	42ygxDEONTj3I7VFmUy3AG4BbN/OWxJ/1I03yLqDWf7J3GViueNjkZH539O4zz3EyPtkpe8cZzN
	wTv8oTrZKLG+OTP7meWPiA==
X-Google-Smtp-Source: AGHT+IEEzlTT2avstp8W9weA2W6Cs8uymkdP10+Ia6GaqZlwbET2wqgTzBzk7LE2on4otsU0hU9wgA==
X-Received: by 2002:a05:6214:2529:b0:6d4:1ea3:9829 with SMTP id 6a1803df08f44-6d864d8e653mr49258146d6.30.1732721648123;
        Wed, 27 Nov 2024 07:34:08 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b49c3csm67001366d6.99.2024.11.27.07.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:34:07 -0800 (PST)
Date: Wed, 27 Nov 2024 10:34:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67473beedaa9a_38483294f5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241126035849.6441-5-milena.olech@intel.com>
References: <20241126035849.6441-1-milena.olech@intel.com>
 <20241126035849.6441-5-milena.olech@intel.com>
Subject: Re: [PATCH v2 iwl-next 04/10] idpf: negotiate PTP capabilities and
 get PTP clock
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
> PTP capabilities are negotiated using virtchnl command. Add get
> capabilities function, direct access to read the PTP clock time and
> direct access to read the cross timestamp - system time and PTP clock
> time. Set initial PTP capabilities exposed to the stack.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> v1 -> v2: change the size of access fields in ptp struct

also removes dependency on CONFIG_PCIE_PTM


