Return-Path: <netdev+bounces-236461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86145C3C8AA
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B2B621CCE
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7E2C11F8;
	Thu,  6 Nov 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrFU4uui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB32EB861
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446901; cv=none; b=LrxNX11IpDb58EDDHiVKsQ0NVRhgjNkzI7jS1MR51faVOXKDYySfkbnmqHa+jwR7joVnVi3mEnucMZwUssV074bdjn2tYRyN3bWRrtvlCCNlLthlAomCBmixKwEqUIsXWC5JV1lKKRDxTrvrABG/O21zK6JVoSS51Eq46AbGRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446901; c=relaxed/simple;
	bh=S2xZaoN0/9NKqEZ/LxpQSSnre7GovkgUOLjfiJO63TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkzF7Kc01PsEiRQE4zFTWYAFRYl4ABXlNFnytaB7SeOW1qpuV8h1hIeK8Kj2aihDSfcatJBu1A7zahJooE1qoBkBQ6oBySotJYiKZcf+NeQHA9egKc/djQmg1m+sCfGtgNe4Q/+EEfrRwgfBK8zDFAJWxzfzVDkQk9c/DK9sl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrFU4uui; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1130930a12.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762446899; x=1763051699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTkzakdXniW7LT8+NpdMCmaXu18bzvGEjXnRp0DAFl4=;
        b=MrFU4uuixxGc1fZ8AVG/f4bw+K7KHSukYTuCEoKpUwqufPhpHewWDmj+r3vMv4umR2
         Kt3CK9gtCSakPejRUpqcQNrKdIju7ZTZjNW6flSImzr/ei7Vn2rpPLgqJfVtNM0etoHG
         q/6UH7ebPlRoBzMvFTK5oNTJd2Ipx5TfIbslgqkm+TizIRUIhui44Tc7qg3B0nKDNpaK
         Ou3++CiQtTp19qi8p0vJBgMOAneV3Yg+ayzC2RiLZdNJATCPc19f+VtAOBNGi5w++vI/
         RRqD7l7eZxUhS621cYLAB4S/CkylZ4b4nti+4eZeoLzT1j62fR8ovSUzo2Jw3QkYmoqX
         Vkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446899; x=1763051699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTkzakdXniW7LT8+NpdMCmaXu18bzvGEjXnRp0DAFl4=;
        b=XZfcBFluZlaqr4HMKAPu/Q4p5K5Tfr8oItlJZJ5BKnnLNaaoIzzhfWumqYTFV6CVZG
         auvWf1NOlXgX60744pWvYm7s0jdUb2oKWvxpC0Fu7uUVq8gLCWP6rTztiZD5LrBxz6eB
         7BvFKsNGVUbsxmmbwqcTAOioyRNGT/ceHfdGAGkYcuK0E9kUPw79JXJNzVxUVTPjBHr5
         KBjk/20pVq6d0Cd/EG3XweZ3NnN0Yb2q5E0wmicFqmGqBEFm5vovT8b8qjzOMyQVN/Fa
         4OcNqfZ7DHcjoqY59IXuZ3634T42uFyNYwW2ALPGKysp5o/WHflqw8z9nRvNSRFHJ7+l
         korA==
X-Forwarded-Encrypted: i=1; AJvYcCXb8oHWpj18zl/6pLqWDgKexmvSmpP53Qq2sdYrQ/s8teHnwWfGTS7zjYeAVqBxbDUzOX9HAQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjjaaaF4KRUQEvZloCW2EeUI/1FhfJvSe/2pt1rdI5QXa6pmLe
	WJfAl4iSoNejFtF/OtsOqkWmLecPxKlr0WVVFaLGQrB9bgGb8IQlhEM=
X-Gm-Gg: ASbGncuas4A+EML+LA7y2pAINMeoga9lG7E7D3bZkhkl6payV+ZoDGriCLJ8XzrUWWR
	H9FPCvsKysTQ3FvcDRmYqKRr3XCmwDVth7qEEUKiQoX9zTHdDdJNeCKArc/tXf2hWsB74fGRHDA
	Pofo0+VCVSMs6oT08aUK2iAPxjdC/EphRMVQZR+i2IWV3srtbDfW1kNnFRRr+8lbuE+J7MbqAgt
	oWHki8sUHexE4XCEhtTFntjmFE1yl0WqjJL58EDHyUM1i8kqhWShH6JCa+eF+XrNuN37ic/5NaP
	30CEYzRi5DZ/YRyI9OdPp8S3vjGg/KZYwwAEnJy+o6W4lhqMdYeS4JrE/DBmoqQo4iLQ4TtVS34
	D86PAZ4ZdUIN5I1Ju4IhQiLq1/5f2Dnquji1T/xKzSHf3D3LtvrV9wZXIgx/T999IHN9qUVSOrl
	IofEexXPbSU/jObK0Q0x2SeKW1nmu3sp7ZuGwh0/w3ZT/sPmrGfRnTfNk/VAfVfrBNcI6e5HsXn
	Z0Uh5Ra4uN2VdsoH3P5MfMo5FgT6FEmlh+B9bXYyADujF0ob/PVaFdG
X-Google-Smtp-Source: AGHT+IFLVphZ1YtY3jlAotYKFR4hisPsLLj+yADHQyAS6Ej0KauGHBUbXQKpoLl3ILVy2QX5eVW4Qg==
X-Received: by 2002:a17:903:2304:b0:26d:353c:75d4 with SMTP id d9443c01a7336-297c02a9301mr1870565ad.0.1762446898635;
        Thu, 06 Nov 2025 08:34:58 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7445dsm33100555ad.62.2025.11.06.08.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:34:58 -0800 (PST)
Date: Thu, 6 Nov 2025 08:34:57 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, sdf@fomichev.me, joe@dama.to, jstancek@redhat.com
Subject: Re: [PATCH net-next 0/5] tools: ynl: turn the page-pool sample into
 a real tool
Message-ID: <aQzOMawFQHUcUT-X@mini-arch>
References: <20251104232348.1954349-1-kuba@kernel.org>
 <20251106070247.7dcefc97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106070247.7dcefc97@kernel.org>

On 11/06, Jakub Kicinski wrote:
> On Tue,  4 Nov 2025 15:23:43 -0800 Jakub Kicinski wrote:
> > The page-pool YNL sample is quite useful. It's helps calculate
> > recycling rate and memory consumption. Since we still haven't
> > figured out a way to integrate with iproute2 (not for the lack
> > of thinking how to solve it) - create a ynltool command in ynl.
> > 
> > Add page-pool and qstats support.
> > 
> > Most commands can use the Python YNL CLI directly but low level
> > stats often need aggregation or some math on top to be useful.
> > Specifically in this patch set:
> >  - page pool stats are aggregated and recycling rate computed
> >  - per-queue stats are used to compute traffic balance across queues
> 
> FWIW I'd appreciate any feedback here. It's hard to draw the line
> on what to implement in a tool like ynltool and what to leave for
> the YNL Python directly.

I like the idea. Python is useful for local development, but shipping
it (as of now) is a bit painful. I'm not sure what's the line gonna
be between iproute2 vs ethtool vs ynltool, but I think we can figure
it out as we go.

