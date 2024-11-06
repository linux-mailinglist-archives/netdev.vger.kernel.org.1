Return-Path: <netdev+bounces-142423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8067F9BF08C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F6284454
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6B51E909B;
	Wed,  6 Nov 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Shsw/FHq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0A1CC14B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904168; cv=none; b=Q/PLGtmoy+Hf2EPruKEo/R//0FCw80enLsdy61daRIrOfWS8n4159+jm+uREkzQ4T9tkvJ9s5Vl1RcpscrBfZ9eN68igV454uQ1Fa9XNNUfHbz3mHad1WUKXUHuazze1evYovRkLIZosvQLmhvPIy62AHbNg4G6FJDkQgtLSf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904168; c=relaxed/simple;
	bh=w/T12pLrwFekZWLQkG6iXZhkqC5oOjo9r+/EsD02cbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCp1RWaqqg7h4B/3PQp5YPsW2pjBz2DihKNfTzWLUOMuCvWLJ0zjttooRbZ2Q/bDRfb96eFNCb0TcUzzSmXIOzlR58Z7RMLwFSoEL85YbfWhEXQpADeu2uh4Ii6ipLzTz9oJwVU/lAE9eTzxNyFgYN7N/Y97kymG6VMMAa4Amnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Shsw/FHq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d47b38336so5150993f8f.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 06:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730904165; x=1731508965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/T12pLrwFekZWLQkG6iXZhkqC5oOjo9r+/EsD02cbA=;
        b=Shsw/FHqykzb9/TAa/qGv9JVgnWWcyLjaif7ssChVGJWyW1eiAM1f5uo4qwdC9yCgT
         tEQ+chfsf77XIfxIb0TFuDCtcQxjtxtaJPB1ml0O0sr5q3gfAkj/I1gvjoHgAqYoKgLr
         uz5dxbZ4WBkg+iKzctNVmrtixGHSYCas27LqDdUXzulqsTjjLOKA+3RliTFzJmywrcYO
         MzvRk7A2wOQ2aoUW2pJWkVPpVaLe+s7YvsWDtJgy7ig8gjjcto4UnMtRiYu8DB5wHgGU
         ZboNLostMo+O7Fqm/cIfwBydT68Xcyz6U46LR3nGuvs1i6IvO2cYege/xHj1GdKSTHdF
         q08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904165; x=1731508965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/T12pLrwFekZWLQkG6iXZhkqC5oOjo9r+/EsD02cbA=;
        b=KLxyTlbL04L55KoC+WX5VNCmEsdggk2x1qr2lq22ZIo4H5XRphGXcHlSYoepVIPnC/
         id5oos0458+cacvMSgub0pE1m+enBlbQ1H9oX45d71F/4pfKuaJcvJ7HusKEvMRvcdJV
         vDckjfeuZgtHiVuoOL2UnkvBIBFyygc04va7DeuDGFox9CUUixSaR5+PdMgZLHCSulb8
         GyR2D6yfmmkiAZ7bnvyAwNrWQo1cGA2zKZm4BJfuIdImvssWJ4g8ZPXLilzspZxjCS/Y
         sHlCORBsR40svzf4/4CENuVOzrtT633+no8homcBQWc5u7PppovAw8PoqRpAUJbprFDL
         nwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNNIR6GkV7K9x6+Wr9qUbtj9rOFNoW5Y9BaQ0u5AlkpCFB8aPfcmjPQfnCkpum7nzZkz1wdqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSmH6eluSmnblrEoVbtaZWRSq7heGRuYy3J9ldMWIPIDjZyVM
	zOtm8ouiFjKOSDF8VP0lAG6qRlkJlvVM01xRehC5WFEXbB7Dl1ePQkzjBhudcJpp7nPyHgWncpf
	Q
X-Google-Smtp-Source: AGHT+IEj7DDDgjJGqjAL6G6ehbFSukuRXVP5DKSB6trScqHTBzKbKGL0RNb9VtHv3hM/eCB76xhdZA==
X-Received: by 2002:a05:6000:68a:b0:374:c8a0:5d05 with SMTP id ffacd0b85a97d-381e18314bcmr6108769f8f.50.1730904164884;
        Wed, 06 Nov 2024 06:42:44 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7bf7sm19642445f8f.9.2024.11.06.06.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:42:44 -0800 (PST)
Date: Wed, 6 Nov 2024 15:42:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Message-ID: <ZyuAYISuNQh1r7Ni@nanopsycho.orion>
References: <20241105094823.2403806-1-dmantipov@yandex.ru>
 <ZypJ4ZnR0JkPedNz@nanopsycho.orion>
 <9393e900-b85e-428e-a2b0-9e3650b86975@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9393e900-b85e-428e-a2b0-9e3650b86975@yandex.ru>

Wed, Nov 06, 2024 at 12:03:57PM CET, dmantipov@yandex.ru wrote:
>On 11/5/24 7:37 PM, Jiri Pirko wrote:
>
>> It is odd to write "I assume" for fix like this. You should know for
>> sure, don't you?
>
>Well, the final vote is up to the maintainer(s).

Vote of what?


>
>Dmitry
>

