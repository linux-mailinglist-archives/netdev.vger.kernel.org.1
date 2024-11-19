Return-Path: <netdev+bounces-146164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FDB9D227F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6006AB21965
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E0A19E83C;
	Tue, 19 Nov 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FUy17ijU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3288153573
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008509; cv=none; b=dlaqC4JxQ/SftFPmaWdPVBCnNts1P8n7MsJYZk6oz9I96+UbcB3Z6jrOLl6YDuFsp9iVVGDbQK+boMplrcAGGajjxHrtIgToxBbrJ3AwQ+Cp8XPWTqmLEGBMRafKDt9PgJApgeFqLdwmmvmTHnE5OpqNvIZTyLA/RS0b6Atl/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008509; c=relaxed/simple;
	bh=JdpVvRhcurMNpFjbxy3BGYACwlmyPyA5j9wR7fI/7Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSbuCmZOT9fsmu1JC8p/z/LaabSYgIyluzQxAY9w1oC+2lpsX2K8nHX9ei0CPVrBU03uqlMGDqwAzxmJvS/MdqoJPmxYYE2rD78atqRqdJOgH5g98zAWgHx9C3aYH0AOflIidXG4zAZMs/P280HG3Nf+1IHWff5ICRtsDZ1/fHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FUy17ijU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431481433bdso36132695e9.3
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 01:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1732008505; x=1732613305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdpVvRhcurMNpFjbxy3BGYACwlmyPyA5j9wR7fI/7Bc=;
        b=FUy17ijUzZ5VfjRHZrHcWjF/Asyw4E29SdroAwQMl58d6BpXbTyhlcd1CtaSlwYlgS
         /EPIE4q3sAzEW3O25wqD7ycClJuNgjSxATLqqwsnhnS9/QiOpqRC6siwMfKlE+joL1VS
         wEzNT/MI82xSW979sBXdcqy5yUPcpn9WlYqeY/78Q89TXyfpCrIlfwJPZoW/K7DMIfzu
         ckJ9V+fp5fg5vOwGbjqyvxZi7OyGDl+ZAj24tHtx1N3/23ZJLDRNGFWjxZ8b71zDTke6
         x3hS4fLuFPwhX4Y44ATCjKBYE6A2O6phAprLmurwmptjof5kDvxgaEW99Z36Il64D58l
         95pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732008505; x=1732613305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdpVvRhcurMNpFjbxy3BGYACwlmyPyA5j9wR7fI/7Bc=;
        b=X1uXWIP2DkTD13/JeOlxzCn5psV7uB0It5SXkElV9a/EW3RnIzw6LAZRdCY2A4dg+O
         v4qLHFw1vSSC4SKtMqXrwk/OYazvwg/Y1kmGxFfFX7sBZA5gy6Lhf2+Vcu6okw+0lPNK
         PyI11UI+dbqGit4bYw4TqudXevIFLebO0Jovt/tzu3Be39jgz1SZf6nFpuqjbiV+cmEp
         rZ7nVB9dmgQJ4l772IIykHntwnWixOYWoWc50jG1W1VphhpKmpbn1vW3Fc2t+iETJN8N
         ep2QTPy6HgtGekcHtU3wbameIecWOjTKhH+A3QtpPAoUEDFzBkR0dmzwVHcZ1+H9gHK5
         dyTg==
X-Forwarded-Encrypted: i=1; AJvYcCXPVfJJxPJaazovXlMeAQkKN5LSuT+/QNbnuJOUNp8FXodxJd9tMazQ72zPzBFNqHAj61mrteE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMjkVoY9FLimMB4bByF4cjtFl8jpdbz/ujD8NBqY0uXROnpBL
	9VciwFHLsMH+asOUfgCDBYp39gHQHp0zvw74fZvJ20+WWXNbZ1zluQx85k6iqpI=
X-Google-Smtp-Source: AGHT+IHo/P7Rcl7U+JKZhGL/GYdkQIs84l1Eca9m06vL8Pg17crKMmGeAy2v0M0/VijarsnJSxfqcg==
X-Received: by 2002:a05:600c:1c11:b0:432:9fdb:1490 with SMTP id 5b1f17b1804b1-432df717bd8mr121164445e9.7.1732008504779;
        Tue, 19 Nov 2024 01:28:24 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab72141sm185755975e9.1.2024.11.19.01.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:28:24 -0800 (PST)
Date: Tue, 19 Nov 2024 10:28:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] rocker: fix link status detection in
 rocker_carrier_init()
Message-ID: <ZzxaNFWQlamJJjFS@nanopsycho.orion>
References: <20241114151946.519047-1-dmantipov@yandex.ru>
 <20241118184201.3d1e7a13@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118184201.3d1e7a13@kernel.org>

Tue, Nov 19, 2024 at 03:42:01AM CET, kuba@kernel.org wrote:
>On Thu, 14 Nov 2024 18:19:46 +0300 Dmitry Antipov wrote:
>> Since '1 << rocker_port->pport' may be undefined for port >= 32,
>> cast the left operand to 'unsigned long long' like it's done in
>> 'rocker_port_set_enable()' above. Compile tested only.
>
>Jiri, random thought - any sense if anyone still uses rocker?
>IIUC the goal was similar to netdevsim - SW testing / modeling
>but we don't really have any upstream tests against it..

Afaik some people are still using it for testing. I got couple emails in
the past. Not sure now. The thing is, rocker has real datapath,
comparing to netdevsim.

>
>Unrelated to the patch, so dropping the author from CC.

