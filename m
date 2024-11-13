Return-Path: <netdev+bounces-144612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC59C7EEE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DA1B22ACE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA918BB82;
	Wed, 13 Nov 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htMsAJZP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DE6290F;
	Wed, 13 Nov 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541705; cv=none; b=iAiDa/kF3pL4lD8ialtUyQ9bWQOdogxwNnTtFM8snhWpzWAGdBfKjGWSKb97QN5GXK9D0SjzGv5av0/N51ein/B5wiychpXPSDqfLwb5g7rlOG4FI8eppNkP+ElIAtJxZq07GBIcEGEMCLk/75cvi8lBIrbUHuallXUFj0h+wmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541705; c=relaxed/simple;
	bh=fm4BAa9aVYryYoUmZq0xJB2lKjdbqWYFpuGuuebXaCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCGr/jlUAGXR61XvPtQvjOIc96SRWtFRbH3gtkXEEXvoBNZcbQTFci2Nr3dPag4TSI14RIj1YIS1bTTKexZilDB1TNzxOz6WMMTeH41wy1RM2+A/clrymExnXCp8zf82ADxzJCo1E/QKj9Mptpnn7CNR3jhrIxEMoyzdrRb4XqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htMsAJZP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso77420a12.0;
        Wed, 13 Nov 2024 15:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731541703; x=1732146503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kd6EuIsqImW/y0jJupAS7bLOZlIiAbvEivkMAZJe5TU=;
        b=htMsAJZPa8EhiMvYJSIvgoFDidcD7/KHelJmkNw1uXAT5kaY0gb8ER0ek/cygngrzB
         Jqlx8n7YsiF+EuNgnrzNLjjA7x6Kv5PqBNRRCq9J4QP+2hAnFTCxL84GdyRC18+5W1dI
         hv+/HdsyzWnK+RCEiBdVjVXszDtjeWl8k+2KZo34gzzAxX8z5pe+2YduTjgP3Lp+yH5a
         +mM6TZovo6WWMo6f3MuSlv1GYBrIbQc7e66KDrSKG+QgpgrE7snIpUPBmwv1dHTyqKkF
         5ErDpM3gE7jkiEaTmEZJHzMx4XaVM6QrVndl4g+sNZ4aKtvGxA792/FFku/2UPtHGr1y
         rtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731541703; x=1732146503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kd6EuIsqImW/y0jJupAS7bLOZlIiAbvEivkMAZJe5TU=;
        b=U+WL2bRcVyGNFAWwRNR8iTIjWsTMt9XWOprGrPUM0HTvhrcrk8hyJOIGCVVNCBMIbC
         RW5diMLiWkxLxFU4n2oq62MFcQ4Us+ojI/OmSq0sTEhFeZZtQZb0qnLDF7GvwwqR0Jst
         37VG1EqKVt6YIoDk5mKRigfPku1a6O8npnWwNcsxVl+Y/0zBF3hc4piRYY1zdfS0wKB8
         IerEZwUTi9SEnKjhFFxhQdvJjv7yUUDN9nr5JcqzzzI9F4LhEpY/W1rtWvNTjE7KAVoe
         gqC4bGPnie3zuA3bHkTS301o1zCXBkHrCSPCGcnrRjdPoalOgG/8HfWMxLRrZxwOsGdz
         e26A==
X-Forwarded-Encrypted: i=1; AJvYcCVlbyAwrJJ38G7fckFC+gKzHHH+sFQbmMfs+pbqpAF15cnf8bJvmuIztXNf0lNDqZ2BMXG6W0zY@vger.kernel.org, AJvYcCX5Il6rpe3jiUbPmGL7FXM0D0z3Zx2diLl5bmwJuLd94DDCFb1vJytWurtUNDcQQS29hrzLko1CYRY1Z+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNMLGwXPzk4XC+DJ2jHom6/uIJ4tLmRBkVXQnljst73hkLsRt
	eAYjUCde3gatiqaOt5MlXmJM/b+so8fPh7raSeyAAXwO9/PyEbU=
X-Google-Smtp-Source: AGHT+IFAuJSp5nVYmmmuevkMPjlCBqK/NATO1pDGyfx1kKjYKi08h3bV4GYSAcngQYAJ2LZZXG9C7g==
X-Received: by 2002:a17:902:f711:b0:206:8acc:8871 with SMTP id d9443c01a7336-211ab9875e4mr115614405ad.31.1731541703533;
        Wed, 13 Nov 2024 15:48:23 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc9f23sm115849305ad.29.2024.11.13.15.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 15:48:23 -0800 (PST)
Date: Wed, 13 Nov 2024 15:48:22 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	donald.hunter@gmail.com, andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 4/7] ynl: add missing pieces to ethtool spec to
 better match uapi header
Message-ID: <ZzU6xjufvS8wfcPO@mini-arch>
References: <20241113181023.2030098-1-sdf@fomichev.me>
 <20241113181023.2030098-5-sdf@fomichev.me>
 <20241113121445.08cdb25f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113121445.08cdb25f@kernel.org>

On 11/13, Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 10:10:20 -0800 Stanislav Fomichev wrote:
> > +    attr-cnt-name: __ETHTOOL_UDP_TUNNEL_TYPE_CNT
> 
> --ethtool-udp-tunnel-type-cnt ?
> or possibly
> __ethtool-udp-tunnel-type-cnt
> 
> but let the codegen do the char conversion via c_upper()

The latter (__) seems more like a variable vs the first one that is more
like a flag. I'll try to stick to the __ form, but no strong preference
either.

