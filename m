Return-Path: <netdev+bounces-145004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D30D9C90C8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D501F2369A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC4D185B78;
	Thu, 14 Nov 2024 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIaU6ibJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742681C683
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605256; cv=none; b=nrd/k0vr2fgsBBRCUPiz97TXWHPdvOHWVLYE3liMIQYOxGotFittcZis6WOgyP0wUX8rBX0AdtlrBXicaWzA/YD0JZA54RanYjQlfayV3m7Lt1KhnH0Si4KTZqxBHx7lSMnoMSbvHjpeBxThm4bCCnVTQ3vNvGwnaGJoXxABU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605256; c=relaxed/simple;
	bh=cBJmCpAwswPgQd4C3Sfivvkda0dsQkT5AmtfV7ZRGZk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YWzEhKQx+jzBWlsbVv78XS1CsPZpsDACiuNliXd2eqWgV3mJbEwe8gC2NvH9ONkgJcq4BmwvLtRP2s1286DGsCAq839vvOowGxURRlK0u7Dd5MgMIa2UAIsU64jxmYShcuHaVHX9uf/7DIR72Als+w5hI/QJ1FHsAREu5xsBwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIaU6ibJ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4609967ab7eso5662281cf.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731605254; x=1732210054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vLjpnUilUSe0AN+0E5B6LmtiA3DyMOP8qJymqdUv4U=;
        b=EIaU6ibJB+UVMstlJQo6h9e1Xq/yerTxdTszt1bbVnnq9rR3c569Nnm/ti32NKb0qq
         JkCppAjburjnC9sUbWl6Rbv6ZaaB678fUGmPWL1Vbh73wFI6YJHWLUI9N5W+E/FbXQdV
         SsnjBSgBhwvxKo3dHYczISrOxgss1hogSAG8U2oGCHtMVVfvt1dbxARi2brVSj9A/Tq2
         4nNq2Guc1XrxSnbvjaXjBaBIZOjWQOkfpjWkZw35AmKBfd9d2d5MBZGQEJ8iIJQAQyEr
         6GlC2vf0VbXDqivN7N7HMCV97YZg2azGli25YPN2cOTxLs2LKBakTgeHTTaEXkAd8P+i
         KxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731605254; x=1732210054;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5vLjpnUilUSe0AN+0E5B6LmtiA3DyMOP8qJymqdUv4U=;
        b=o1v0VgEtGbtogIL7kqFgKXN7eDMVue+Ci2fP8aItYqXI2D6kuJAAmF4RZBXYMKSq8x
         /vMLBLsMuro83lQk6RLl/rI1ANzrSD7Id9oz0mn1VDXk1nJo7a8w0+wzKYrll+/p+51I
         b/J4uHWGqfmtWyPIcn+74CJBmaHBHULq1fWNIvbAg738f5n4xzpRIfwJgiOoWHtCu3q0
         wOoiInulzC/wquSVhniF7cbiBKsBZu0A7mgzG5gC5J+6hheBjkV0jub3DQ/kxfN1D/BF
         cP52S7sf7bli/dDluagprJbnia1e1xHjbFWHzeaJH1i5i6asYM06QspQBed+aJqTJ2nw
         Ojnw==
X-Gm-Message-State: AOJu0Yz7Z9ABNueAhINx0AAIGVc5+BtfN8iGBuhu9eeO3BwEFxlnLUO3
	PzKbCzgVgZDmQGTil6N0ZWVxczBNm8I/2SlFxwVsPSjWTDneIJCZ
X-Google-Smtp-Source: AGHT+IFCuK27+26tZ31QAg8A2Pe1TTIj5IB/UrkmY0uHCy3DO8GUn5sB5uHzc6BxjNX1ot9/XF7VrQ==
X-Received: by 2002:a05:622a:144c:b0:45d:8b88:a98b with SMTP id d75a77b69052e-463094115b4mr297009391cf.35.1731605254373;
        Thu, 14 Nov 2024 09:27:34 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c9acaacsm68615385a.56.2024.11.14.09.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:27:33 -0800 (PST)
Date: Thu, 14 Nov 2024 12:27:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <673633054b685_3244ed29482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-2-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-2-milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 01/10] idpf: initial PTP support
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
> PTP feature is supported if the VIRTCHNL2_CAP_PTP is negotiated during the
> capabilities recognition. Initial PTP support includes PTP initialization
> and registration of the clock.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

