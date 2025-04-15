Return-Path: <netdev+bounces-182578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3970A8928D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 05:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9912174365
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881611F4188;
	Tue, 15 Apr 2025 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHyIbpgw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1509C78F59;
	Tue, 15 Apr 2025 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688029; cv=none; b=gi88DVUl/I+bItK0Sm455r5Pl9NVdsmDJEgr23EzE3D5fIUvldP/vjk26NYm4nhPOt8eC8H+f2GIVpfuUTuhw6QbwVGF3gbJmNp57jpXUUEAt+fTHEpX29IQZ5xpDqr/22+Y6myqLUhO+20wT66ObRpiGQxaKZ+Lf7uWoNHN3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688029; c=relaxed/simple;
	bh=PD4IETagEYw9szCMDtrwf/DURPDv6bR2qwauiy9/ewg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbweHOotuj7g+F2l2c9cIyZp3qoEfVIloTEArWofqSbfPOd2HmPrAO1oVUKbdf8q6QO3t4cgfm/RPfPOVwxMN6WsBWKjMtWVCmCNHnfUwuX7iPvrpSyN8eSDJ+Ud6xqfPArvhJ6Es7WPrhIPB+z+CvTCT7bSihk4BoL6aEODjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHyIbpgw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fd89d036so60852035ad.1;
        Mon, 14 Apr 2025 20:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744688027; x=1745292827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGR66RJGijWfsj/Wy3cJYHe1Qxgq0Xxw8JFWHJyYQBo=;
        b=kHyIbpgwp9Husjvf5Oveqbtp51i8axVRhXMc2rOJv9qphaPj3x+J9bi1Gj79ut3CQs
         5j9mqprgP9D0CTRur0kc8rVB/bBqpbN1YU/qWaGRRC1CvpQwgL6WopiLpkkxU7JLUXgb
         1+yOUqs92KM0eyfIeSOScxfTYv9GE1hB3MZC+DGqWlgkb6GXCJC8TZTzQpXT/F/Qh2hB
         AX7cP6y1aH9bFuQXf7fSaG5qkq4jPxYUiBvLHr2RDloLeZumB1KhG4J+oOFJujZvbmZE
         eEGRslssZO3l+aSZcxpD6Q0NNM9cTkK3UHKggTT0L0mS2N88J0TzDp2XlWnNwkKhNhl8
         EjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744688027; x=1745292827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGR66RJGijWfsj/Wy3cJYHe1Qxgq0Xxw8JFWHJyYQBo=;
        b=rPLjC1jJdhHIVHuqvY9RY0Jc5uAZGff5TW296ic+ic/mnaqCwYKj818U1lCQaa0tsN
         bLgYvKFBTX3SlRKGvXcX9sKqSCl2pzQuWA/Q0+C44wdnSXgXMr2VSN17YwGJ1rzlo+I2
         rv0phe9IswR3/4I7IAR/Jk1Ea/wPbj1iRcAoDtxbmwiG9iZ8+qnCcJ5VMAsxRTq5SWES
         oZnMymKdWzcDE/xID8WUcD6HuGQD4QqzKTnDZ8EYC88AAxVxe+gop2FGNIaWo8ephF0E
         6rxaYRmOxSqdZx79F9QM4RrHkYucuN0Krse1MCVjHTbLzwZt8U0Lavz5qkFF6/Od0DSY
         KQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqUTXbqxSoJffN01CPyR5jxShW73DtEY5+J1KaRz90ZSEid1oKZgnNWapykqWq7xzUEbK+dax/@vger.kernel.org, AJvYcCX91+77CNBAJu5HV42gaVho949MBYLfqwBv5f/Bs13f9lL7lqnvXwyUIJFPvOSLCCSeADqS4Grgj3HAO80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkD3NP3iK4rTvqCgTUfnpbr/z/0UGvU+XHFlWe2aO1D6XMqh4G
	z++NuXNq+6mec9PRVbLdCqDIBfEN+KXXzmXFnXOR+5/UsHxWuNdS
X-Gm-Gg: ASbGncv2xXo9Lxfqm+dtQsptDFyXVXlKDWQqXEi0q0X98MfXXXjCtUgaQ/LttGnEMkQ
	VNl/Yg8ynBUpDOTyoPk/X2ypH7x4JTxQcYllMyjs6er+reRKdiZfQswUEnEmprBrhELuDB+tVYp
	aXDhRKPks2lgKOS4ykzO+Q4wVZ38AQmcvShbBJyzIOdfwKwlWaCgW2qbzglj1TnwsvFNC+aVNNv
	9CI8U1+S0I1Ah2Gd15d6nAWU8prYUcU8alB48gARAQ60GKP/AmRMOhz+GP8hcRvZMLSv2QjG65s
	i0cc61gUpqrOv5mI2rlQGRU4rkmaHIXe1A==
X-Google-Smtp-Source: AGHT+IFEtT49JwxKT//1+ehfZkXG08nxRxAg/8YIC+mKqaNvAhLGr7ZaYZFdomZXBvzqrB1kbaIDwA==
X-Received: by 2002:a17:903:17ce:b0:223:f408:c3f8 with SMTP id d9443c01a7336-22bea4b34a7mr208771025ad.14.1744688027296;
        Mon, 14 Apr 2025 20:33:47 -0700 (PDT)
Received: from nsys ([49.37.219.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b9042dsm107193645ad.104.2025.04.14.20.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 20:33:46 -0700 (PDT)
Date: Tue, 15 Apr 2025 09:03:39 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: Markus.Elfring@web.de, mengyuanlou@net-swift.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, saikrishnag@marvell.com, przemyslaw.kitszel@intel.com, 
	ecree.xilinx@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: ngbe: fix memory leak in ngbe_probe() error
 path
Message-ID: <ko45l6sl6eo4pfvac4q5ounmjzhebpyhhzr23ohqphncikcprf@mjhrpukcdww3>
References: <20250412154927.25908-1-abdun.nihaal@gmail.com>
 <00b401dbadac$7b36f120$71a4d360$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b401dbadac$7b36f120$71a4d360$@trustnetic.com>

On Tue, Apr 15, 2025 at 10:17:04AM +0800, Jiawen Wu wrote:
> I think this release bug is also present in txgbe driver.

Thanks for the info. I just sent a patch to fix that here : 
https://patchwork.kernel.org/project/netdevbpf/patch/20250415032910.13139-1-abdun.nihaal@gmail.com/

Regards,
Nihaal

