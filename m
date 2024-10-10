Return-Path: <netdev+bounces-134379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1069599909D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 20:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF861C24198
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5E21FBCA4;
	Thu, 10 Oct 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOoOEMaq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67121FAC3D
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584758; cv=none; b=fyf039ey2Ive9TpPmNS68bsIHbwXrYs2oW/qz7DlgM9g/nMa+DSI7BDIrXa35kNLExWqqeehVPmgmjHfLMRsfPCIKq2xTzzGE1OkyRpOu0WsIlEmJGunWfILSAbnk4zSLTWXa1esAmKM7P2R7+7S2OvAgWYLUQAYgq+lFHuwlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584758; c=relaxed/simple;
	bh=WjZnkR+Hp1Z+sTURaerUVo9hnHxey+gpfAsg0efFelE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8NXMqa+myYiBlvtL9y21Ma6lbr0/Yw3GQh8R3EAdqLxsieeOJoQAm3PGdZX6ABUdOA7HhOSt827V+MoyVmmwbpm7UnWGvvt1p5I6YFRMbliA7ZThqEtAR75hiOV48/frlXDp+66VZZItVdep0BFAU0/AuNpFv9GpA2dsA0ADaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VOoOEMaq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ce9644daaso791668f8f.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728584752; x=1729189552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MmVxF6On3Xud0fELRG4PtMnUkfzrftmDE77HKJT1fqI=;
        b=VOoOEMaqekrzuh5tyhYzdIjoNad0OqMFw9WIrtkBwmmvMLplzSR1AJjqRyVzDrgnW/
         Rrwa9MKIMLQvARiyEyrsoM8RDDR/HJecg7ruic+fRjjPO0FlAj3fwSIeJATlWmlIXcSn
         UVzckPPYK08hDuN86C9lUl0qs/88N3kYVsoq6KXrO1KdI01mfaI+jiXmz6cK/+Dz+8iZ
         IQssypRolci7ISNT6LbiNRQjfQgeCO+FsPTv2Lnc6dROe0R0+1xoybXyDhM55ur/V6eq
         lWeXq2sjQ0mROyq2JFZCiY2yGSVV8ghHiNtw02u5KDP3sDEuoUz9tNdJYm8kswOjZ/vQ
         8uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584752; x=1729189552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmVxF6On3Xud0fELRG4PtMnUkfzrftmDE77HKJT1fqI=;
        b=wSxCms4X6a7aTDi8WfSaYzZ2EYavGNaDUIGxysQgDuStrmnZ/J88U/CC2Li5v+TDbb
         VHm/Unot0L9KjiyXO/Nr2gP2jg3eYs2I0dtpcTrlDygYZ++mPSqXjnso89SUU4n/dL5L
         A848gRzJdQE5LfPmPXGkAMblR47Qqo8OlE/H+SXhPVrJ3zvM7ylbOwnR0nCBRf13Gudy
         yE1pGQ01VVf/xHUGCKPRHxr5tvrl7SEx15T7MZkao1xg+4DiCH6dKJWodHMnr+J8GHxV
         6xU9O3iAwFNDCGpjhih6H8ttaOobcctRQZBunYHhD3J0H6UjvLG4NglmGD6izNbQioAN
         0O7A==
X-Forwarded-Encrypted: i=1; AJvYcCVZdIdMnSCrO5rUzYAmuI/RNm3r+t9Bfkkln9CuwpyQuCtiXDfa4WMFhor7zQFzsxIVjvyAzfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvk7m/YDaPdwBCPLKeJfTv9rgtbxXu+WwaRKUVbGs6o57UgY31
	C2w3e32u+Hjr4tetChSfxxIgKDdpdI1w9CJ4gRg7Iknu26T4zaqLrOjfz0wceQY=
X-Google-Smtp-Source: AGHT+IHIY6JDhq5wDjFxcjfx2P1BtEHVyGYjVK9PHPhnpKcVYhsRIOHISEEsl5hFzPaSbEhyokkZWw==
X-Received: by 2002:a5d:6645:0:b0:37d:4e03:ff86 with SMTP id ffacd0b85a97d-37d55313314mr31978f8f.49.1728584752146;
        Thu, 10 Oct 2024 11:25:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8ab6sm2113414f8f.10.2024.10.10.11.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:25:51 -0700 (PDT)
Date: Thu, 10 Oct 2024 21:25:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] octeontx2-af: Fix potential integer overflows
 on integer shifts
Message-ID: <91b7c990-1d8e-45d1-8f31-309301226811@stanley.mountain>
References: <20241010154519.768785-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010154519.768785-1-colin.i.king@gmail.com>

On Thu, Oct 10, 2024 at 04:45:19PM +0100, Colin Ian King wrote:
> The left shift int 32 bit integer constants 1 is evaluated using 32 bit
> arithmetic and then assigned to a 64 bit unsigned integer. In the case
> where the shift is 32 or more this can lead to an overflow. Avoid this
> by shifting using the BIT_ULL macro instead.
> 
> Fixes: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> 
> V2: Fix both (1 << i) shifts, thanks to Dan Carpenter for spotting the
>     second shift that I overlooked in the first patch.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


