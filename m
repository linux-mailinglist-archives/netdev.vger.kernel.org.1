Return-Path: <netdev+bounces-141007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D21379B90D1
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892241F231DB
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C75519CC27;
	Fri,  1 Nov 2024 11:57:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B116F900;
	Fri,  1 Nov 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462267; cv=none; b=Kq+OH1TTvzUw3PYfuSqAUgXz4/py9VCj+zLBJNCEZrm+EIzwazPJeDjYzKNpMfBIo5wdPRbLEPjFDgv6bU8mXsPH0lNgnwndAzVlIXIRc2DUMg1BKdE5z0lKvbH+ni4WDmnb39sxGfi7g7Q6YvddFXI7ixrunYU1bbo0Y/tnM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462267; c=relaxed/simple;
	bh=yLw8xEq/1b8K35aaH22NngHxzHBi3Ijgl0LrVa3SndQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsQ0D/4cb+ZsTrcDbIXf6D/2kzZVDrlg4j6lgZKfGMTYTkam1wXt2ZUBn1Z9TXpQhyV+qB1DXX+i/BYT1HBB6/BhBAmjXfry7Mj8o0K1rItTAWTr/fNr2Kt0nG+4DXifFpihwOpMRHGtODQYG5Unudo9PIStCYAD9gVFCOCm3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99eb8b607aso216723166b.2;
        Fri, 01 Nov 2024 04:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462263; x=1731067063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLU+pryvRNzH9WF78IXUWahMv9RhwfLSfAmkinvL99k=;
        b=WnKZ1hUFstwJjHLYqM7CU7ykvO3Z9+03QaqsPC9Qpls/cOU36rpA8qcxAT7sXwI+f8
         TG8+EEVH6yRs5cnQ3YRTl6ZdPozxuwzFtPTOy1MxYGmKpAU63O54hIRiX/A2V0SSZf8z
         V4sCYBJtMvJJxM2sBEH1j8RNOn8jS82kZecip5dBOZWCzpOJzsJTj5+3xrjn2SylWr/8
         Uy1FMUVe1V5ua9IPe7Nxja3rpis4oeu2VlNOy57oBFtj1Mo7t5LNYuo2OclcCuzljuV6
         B2nXAE8sZRsO6EhHkf4awnR6yOBez7kOI3mliy0lKYGZKfWKOjgcQ6vBwskKLbNdc7Wn
         KwGw==
X-Forwarded-Encrypted: i=1; AJvYcCVcmSRoIVMNRamxI1it+kFvtprbh2Gd3iym10wQcgLMn0Ix7I8v6FEYtr5MRUd2eZOq241mW3zsM4yKos8=@vger.kernel.org, AJvYcCXqYX3E92yBKpvbj0wvvY3HB8HYOyoPvLVkdJWSEg7CUMrpE3MNsrRWGtex3hEh/kEAb/qSm5uP@vger.kernel.org
X-Gm-Message-State: AOJu0YximKmsSTcTIKrB0fAIE+L/bDSu1B2OtKw843kwneOm7IfV71uA
	yTMS4YJrgZx5drTWhqbsRp7BZ0aL++knvOI+Q+vrWu7UBqwpXSIn
X-Google-Smtp-Source: AGHT+IEKhsKj1NrfdPIu9tJjrayiDRntn19oWzkI54uNcFCbWSc9R30FGlhlyYzJerRrLLH0VCJkCQ==
X-Received: by 2002:a17:906:c106:b0:a99:ff43:ca8f with SMTP id a640c23a62f3a-a9de5d659cdmr2203883666b.10.1730462263225;
        Fri, 01 Nov 2024 04:57:43 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565df901sm170451666b.117.2024.11.01.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:57:42 -0700 (PDT)
Date: Fri, 1 Nov 2024 04:57:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com,
	jiri@resnulli.us, jv@jvosburgh.net, andy@greyhouse.net,
	aehkn@xenhub.one, Rik van Riel <riel@surriel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 3/3] net: netpoll: flush skb pool during cleanup
Message-ID: <20241101-funny-smoky-ibis-45e47c@leitao>
References: <20241025142025.3558051-1-leitao@debian.org>
 <20241025142025.3558051-4-leitao@debian.org>
 <20241031182927.342fa345@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031182927.342fa345@kernel.org>

On Thu, Oct 31, 2024 at 06:29:27PM -0700, Jakub Kicinski wrote:
> On Fri, 25 Oct 2024 07:20:20 -0700 Breno Leitao wrote:
> > +	skb_queue_head_init(&np->skb_pool);
> 
> This belongs in the previous patch

Agree. Good catch. I will update.

