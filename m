Return-Path: <netdev+bounces-103191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96A4906CA3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E86128197F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6C145B2B;
	Thu, 13 Jun 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsyRQ8b3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391916AFAE;
	Thu, 13 Jun 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279381; cv=none; b=dZxCdvKMG0G0K+UmadNPEtqUY/PaxwkKIxCBw6xFVC0PvCoc/xd/wVm4ioBjzpb1aFAXFJhhCWgFqmkdnxqa03uHw2JDr8gvKrqH5ZcCCzm1lNcwn9ISHc9PebLL/tUYF8mpvSupN8NPW9SqbwNbZrdGqmEF7SUwkWO/boWXaxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279381; c=relaxed/simple;
	bh=1GZJqbBXeQBsgb2/Na1JVFj86yiEMw5IVWrXUc2PSXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNcZIDMKzt45BfWoCvLvFkT5Vlj8yrt4BhPOsnK1v9K9T8IqO0tFB8wVcaBnyYsNssJG4yYGO9y9RzUixrD8hLiVRjsXCMQyiHALATEt4O4+7PowT+0KwWTQaaFH2dF20RpLjZdJ+7+Mcy1TG/wjLp755i1PwIC69FZcOAo588Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsyRQ8b3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f177b78dcso118826466b.1;
        Thu, 13 Jun 2024 04:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718279378; x=1718884178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKZt3TlF87hZWs4MtlsBYXtxgqP3tgAN+Bxb0F8HgaY=;
        b=OsyRQ8b3qd0RkNRH4B334qhJ/bYPL26iDFw6VIpj0/hqXAkYqFHd1i5P2Iz8zn/NLv
         F28azdIEDw1ZDBRt6XdOQKd30b3Nio+2us9/zR/LH00OmqHBbDCbJanMzPwjXpqSJdcf
         cgVHpI/tm5cB27UqBjd1BCjRFXZWlNZV8BOUhFW+fsWYJ21lELPsM+E2n9nv+rylmnBe
         PMyyDUDTcMiqiSgJ/POuCBIDhwqOOKo3edNTMniBCsajEn80RYmbw30f6r8jw8k0yfCa
         b/YohuR54/jYRunbtgYaxAa9MeEy9ys8vJIHntGiM1TcRk+p2G5yADUjI3X2ydSwzrdv
         d/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279378; x=1718884178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKZt3TlF87hZWs4MtlsBYXtxgqP3tgAN+Bxb0F8HgaY=;
        b=I421jpgDYbe2fz3I4I8ign8C/i60xY03HmQq3/Ao++5tpMpDskm8fp7mcK9yaQcXCc
         nYPFdi7At7KjirIgnkxFrXKcUZTswEkrrSlvDDrfH1C7zgsL3HG/iycBp9GXWLihTaYN
         6CtX/vwkUnIVIpqJOLukgn1oWW1ps13ll13L47SlU711LXW2PpZxFASKBdyEW6gI3n5l
         CCDKIySU4O2wlZcVWUQOc+kLBzMbc38vdfdmf55UCYEOGBA0auF01g8CxLWQEP7xNWfK
         QeiEaQCZavAO7Fh2lPfzuJon8gLHnqtOvnubgV5YmU3bTTHTTA7hDmni1NGVF3PZS5eS
         +UJg==
X-Forwarded-Encrypted: i=1; AJvYcCWLtX1hPnfTUKoGl0fVGQP56A0WhuBk0Kt3+r/cLFQWuACTLv0OugqM9czET9h7pgpTCZmdbsrWgmq6astrpfuDzRlrnWmu9Gd+rmc3kDnvzd9ptV0cQNGxY/vM5RLkUtvMxa/hJDCJ48SQsu/9Wu1pCxUbP0g1Jx6BNvSb3tanZg==
X-Gm-Message-State: AOJu0YxBKo8Um+CKmjRmk6wytsmwsy74L3rwTBGLbE7Kv5zuz6SGFa0D
	G9NYomLprfcyPGpzKDgOyLFNVS4CVn3rcahw6opWa88FW0CH/VF8LbrEo3xyrQ8=
X-Google-Smtp-Source: AGHT+IHAM7XZZ/KfLj5LSOrhmG/v3GaxdmLgi9SHE/myuBwocaMn3r6cRMXRi3lAHJ3n7x1qB9+FTA==
X-Received: by 2002:a17:907:868c:b0:a6f:481f:77eb with SMTP id a640c23a62f3a-a6f481f7b7amr363406766b.20.1718279378125;
        Thu, 13 Jun 2024 04:49:38 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecd65bsm63762966b.105.2024.06.13.04.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:49:37 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:49:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 03/12] net: dsa: lantiq_gswip: add
 terminating \n where missing
Message-ID: <20240613114934.vt2dzstw2ue7xlex@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-4-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-4-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 03:54:25PM +0200, Martin Schiller wrote:
> Some dev_err are missing the terminating \n. Let's add that.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

