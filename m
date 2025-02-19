Return-Path: <netdev+bounces-167783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C35EA3C404
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B70E174BE7
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55A1F941B;
	Wed, 19 Feb 2025 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr+gLmhl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376D1FA267
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979793; cv=none; b=kAT+5Kd3YNDGEHikeuHEi6pDvvqqGFHhdTRPxvd9k9V6Rr+kpK6pQZSGHLgTgFZdAkIQZxZD1Rl24xnPZtF7SEJKXHSKPvw8IBZOMa/gjM1JPbU/Q6efPVkPreMA/9R8IB+YKPkcIz7uzSuT/UW6IqfKRxlJ645Xy1UkI4e2FCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979793; c=relaxed/simple;
	bh=PMIavAfjKSmOAlpuBRpfLLwVHhYelydsXE1rjfHRBxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7utWM2YfH/M6iOpzEFzXHcz1SShT8ojnIkCPQW0tIXF5e3nQTew89vD551YL/EDVSrBTBF0cm38SxmAGlZxgSsOcwi0JQXCCA/hXLUdihKYwVKdX3MZaqj6HmOwijy8EgqMR4SJ7+NsX3Qiix97PbYOYBlSDnwpyzwZovWhlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr+gLmhl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220d601886fso93880145ad.1
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979791; x=1740584591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfnMKvDuOkzFD4oPu4Jd3DG62a+8kTqR1I8vRzLoHI4=;
        b=Tr+gLmhlpIf0gJjJ55+SRvbLjXg4B3xFn0dLpxsQfUraSQE0jRutwPBhXxPirT9LQe
         UcDat9xC3JtCqV9IjU/+OiWDqvqhK4Nez0xPO2YWDFh8j2PI2E76QoUoTephXgFn8KPE
         483cVBJ1PygRDkBzjKtqJ9eErlYu1I+hBL9ALD93SrwceMs93dsWB53RxeN/HbIY1j2z
         L4bJNAS3WOsVvxXq/La4KG1x3U+3CVdcsCW4Nhw9Hd8e+mhZjbkOXEWFP5PCONWhfbIY
         jVLz2fG45R17v4q0xowyYCsEJceIFTjDl4US+hJfXqE2fxnIlLJZOzggjWWlJw30kTIW
         9yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979791; x=1740584591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfnMKvDuOkzFD4oPu4Jd3DG62a+8kTqR1I8vRzLoHI4=;
        b=J7ZZ3bDMukGBdVdvlpRJJ6ZH+l2CQ0+F5hT6TA7yIwOPnNz2d7zuIVRJvrqsLVkigM
         VllFrEeH6Mp8UUouyYZyWBUR3oj1pdqE5DN4yRfLpDSV2PF4OQL+q3m492rWuEinmuK3
         OYrrLSaFjDMna3USt/nlDtqyWpCZKj0Rk5/AP9N25/jWLBhiFcq8/s88zMKrK0mN7HyV
         YJlEkYrjrgylSYDCn2GQebO/flJuNtUwY2XljAx3iRupYqjK5Fd7Xf9fE3WsUsb+0zCP
         k/Pdp+bPrd6EI9UiDNceMxQ2oPP7zqCFt+jdG168vhAoNxFv15wTg27arCtjQ6Z1a2lD
         beTA==
X-Forwarded-Encrypted: i=1; AJvYcCV7AW2KIIlgtu5AMMbWAh07Ci6g/yKK1mFd3IkWigkEG4GENQyVi/8ud3VvOPZ2TwCeGJY7rOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhJMVUCrL00pVblZa4u8pRHzGgDB8bI2UV3zqgM9mHLMqHVMr
	AtDy5JgbW/M1eJn6JYpxg3vb62kcol4/ledmKbuas21v2u8WqLo=
X-Gm-Gg: ASbGnctNWCd1mwepAFEzWZIBWlkdEx1mCr+ZdLOvsrlQNbRexKtW3sxRzMKdCOo44mD
	TUn2S4csQObqPsmfxxvU3vnf9rE5LcMQ8HMOIl1taOOity37a24IUvCyoPLqkg8dGVBjMFQZNc2
	+pOEyOomAjMiQHAVHubc1p7RFs1+uMwJ6HTQ69ShKRLj1ABtNnvJUUjikoFWEC3fEdIuO20p64M
	2cmg413rGdbFPDPADKwHQXTaMh1X2SKEay/ymEBhXaapM90KXLG4HVmagb79Zxi8drbTPsseN8V
	aX3CT2CdNDY2umk=
X-Google-Smtp-Source: AGHT+IFfP50Fy9m+U7q1rEtApWLl7C2aT4LlLEwuA9/eVbIuSeyxuyqYQjOdCMObL7QaoEX9CbPdFw==
X-Received: by 2002:a17:902:f64a:b0:21f:6c3:aefb with SMTP id d9443c01a7336-221040bd763mr337819845ad.35.1739979790808;
        Wed, 19 Feb 2025 07:43:10 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5348f12sm107363845ad.46.2025.02.19.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:43:10 -0800 (PST)
Date: Wed, 19 Feb 2025 07:43:09 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v4 11/12] docs: net: document new locking reality
Message-ID: <Z7X8DTdjHsImfzf3@mini-arch>
References: <20250218020948.160643-1-sdf@fomichev.me>
 <20250218020948.160643-12-sdf@fomichev.me>
 <2ce3a63c-8c05-4b70-a6ed-4131fdf9ee34@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ce3a63c-8c05-4b70-a6ed-4131fdf9ee34@redhat.com>

On 02/19, Paolo Abeni wrote:
> On 2/18/25 3:09 AM, Stanislav Fomichev wrote:
> [...]
> > +RTNL and netdev instance lock
> > +=============================
> > +
> > +Historically, all networking control operations were protected by a single
> > +global lock known as RTNL. There is an ongoing effort to replace this global
> > +lock with separate locks for each network namespace. The netdev instance lock
> > +represents another step towards making the locking mechanism more granular.
> > +
> > +For device drivers that implement shaping or queue management APIs, all control
> > +operations will be performed under the netdev instance lock. Currently, this
> > +instance lock is acquired within the context of RTNL. In the future, there will
> > +be an option for individual drivers to opt out of using RTNL and instead
> > +perform their control operations directly under the netdev instance lock.
> > +
> > +Devices drivers are encouraged to rely on the instance lock where possible.
> 
> Possibly worth mentioning explicitly the netif_* <> dev_* helpers
> relationship?

Sure, let me try to add a sentence about that as well..

