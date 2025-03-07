Return-Path: <netdev+bounces-173096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56B3A572CB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 21:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C28F3B84E5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694D32566EE;
	Fri,  7 Mar 2025 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CfSYRyIR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12B2561C7
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378282; cv=none; b=u8VtUgcOmB0VI3lRnM2xetCaRR/1EzV1F+Ku+jFLSXknVIbnIkEOQrGLKGApaeKuqQ0otL/efxWv0qpJcSh/SL/7y59ZL2mtwpdjjY5ezz71w5a232+QfsT1yhP/x8lICV9gLBdlY0OaGBI3+B7wEC7xf+CqUGjPaGAaWegjq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378282; c=relaxed/simple;
	bh=XnokswpRVUawxvrh0+H2EO37FE3w3hGAjLgWW05bx5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVboDl7z2PiJeTUslNelTvEFnYuiNCPCn/qs80cMk+otrxcCjscaxHit9Am/zOxQb+Gnp/mvqLOTvxeX8nJyxLMBWTTiZSJ2qhAzkgJA2q5O8SRrhRNqp2vb0IwCLfFsd2INL5ZcQh4HcZGvHeLY94lUuPgr84KMV5w3xH+Uo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CfSYRyIR; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so1961165276.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 12:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741378279; x=1741983079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XnokswpRVUawxvrh0+H2EO37FE3w3hGAjLgWW05bx5c=;
        b=CfSYRyIRM0jvy6C5rlcEtYOXSsnlv7OSvkQwANLjzG2JXhoMm29V4p54eVVBQaje+J
         fWjH37Oz3gCjbNIjGSRJDd58FFpgoTDu4qHV0L/RSIeIm5t50TJc7cj8na9T0Js1Wx/J
         WtGmHs0cgm5U8BMk1qViLwLSPXK3GwdvDgVDX3krXqKGT6Y0eP+Er1BZoBVCG6zajfT0
         IfFmQE8wEa5aBolFsh6lsZbzpq8YMdrRelsbbiCep5cpxj1AIOdCVkld3PupzTZ4EYnO
         in26eGJxEloLkalZNdVzOEeZtjcFo4jpIQbpDpfO3IE1KSw0IGC/rym+0ZZLVNwj9SPP
         /QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741378279; x=1741983079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnokswpRVUawxvrh0+H2EO37FE3w3hGAjLgWW05bx5c=;
        b=DORekoXIbYHPyj1g9HBeS3r/e5Oh/WBukp/fbm+vb4qhZNxkPPZ+G+b77V3xS9nUme
         YFU+SGaMDHcEL0DIURF0At8ciC3YJW7qeeDXCPA2cBdj6vBCBckdjRzHg7TPeEEd/Udy
         SPhCKe9sFJaCyS9QxVA9aRxWIGoFxmaVo8fBQNbxumzVfmygPKVXt/OgJUUFMnMLOAJw
         Y0f6CifjAYKqBw8OISwwUgIugen3IW/02NSgEx3n/9Wi1QatQX2373jMNQ9L5IkwMFVz
         m41mQ0/0ihgsRMYIgc8IuJO6/+DSfd0puB0Ru6bFdz+IBTH5hfMhTKXVivABXRbF1XnU
         bKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUIAYdE4cuvRsXkrGq++0VkyfndDMFvdlGe1Trlc6mpB8exB5MGd9U3TqAfjNC6yFTren6S1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6aRfcaqP1dwKlnYFnwYksXdx0hMvERIcRE2GA2dlSTbmJa7m
	BfN7gmi6pOsbILHXE0OtTjXl1/AXH8jKoKST39O4McuXeZYuHtLdOzK5LUncy+SkAo3cOllHAGx
	7t2M2QwS4sDsFrfYdvT0GKMR1rdiWkvcH
X-Gm-Gg: ASbGncvpTC5oS+5iyVfh2F1XGWUcCBRsGb7XAOt0I1poANcVaf45o8Ea2NTYFDazLyf
	rZiqqP18Ihn0l27NiQgpTZexpi9knLgPuxk7WgRcwoNKnH1pnUqSF7jf1kFbHv1Ez71odQtc5NP
	m67cqQUzpG8pgc9vvwY+Uu9fiM+SpW45FduU8TPZfjeUAT9OjhVgKbeGoEOWVxvNIgFcj7PbVKF
	I2omZz9U6axS5WWeLlWen5II2dWbzdMXCAwCOEk7IuZfmeRz+YV/RCsAJH3E+MA5MUjjZyFOuNH
	b3aiSN8KLcK1gG6gqIrLUsh2Vjg56Kt4gWUnjn305gVfaloSKw==
X-Google-Smtp-Source: AGHT+IFVIC1dPB2oQzuEy2i1L1p+CBm3CNBs2IFDf0LbWaFMmjn30sMZygpeRyebFOscyIQ6uTQhXSytdw3F
X-Received: by 2002:a05:6902:18c5:b0:e63:3e25:d71a with SMTP id 3f1490d57ef6-e636f7e8b1cmr1236822276.15.1741378279189;
        Fri, 07 Mar 2025 12:11:19 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e636dfd2009sm42439276.12.2025.03.07.12.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 12:11:19 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4B339340245;
	Fri,  7 Mar 2025 13:11:18 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3F0D3E56FE8; Fri,  7 Mar 2025 13:11:18 -0700 (MST)
Date: Fri, 7 Mar 2025 13:11:18 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Simon Horman <horms@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] netconsole: allow selection of egress
 interface via MAC address
Message-ID: <Z8tS5t+warQdwFTs@dev-ushankar.dev.purestorage.com>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
 <20250220-netconsole-v5-2-4aeafa71debf@purestorage.com>
 <20250225144035.GY1615191@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225144035.GY1615191@kernel.org>

On Tue, Feb 25, 2025 at 02:40:35PM +0000, Simon Horman wrote:
> Reviewed-by: Simon Horman <horms@kernel.org>

Hey, since this has gotten quiet for a while, just wanted to confirm
that there's no action needed from my end? Is this in the queue for
net-next?


