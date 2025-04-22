Return-Path: <netdev+bounces-184787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99787A972E7
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2BB1B611BC
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1B293B7F;
	Tue, 22 Apr 2025 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC0drX2k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EDE290BB9
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339969; cv=none; b=WTtAEh8QiTlpGIR4skyGzChYFEu1t+0WqG62H0duD1nHfijZTm8LuYs9/koKJLKG7NY2j7wXj/TXeeeV00xvsM3IMJ3VPeNWguL/CLTx87iwOIS82ReUgndl11Ix3ojbe/4aljXo3WQfChBkB/rHY8A1BvQC738XIyOT1PqJdic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339969; c=relaxed/simple;
	bh=oU2vQqvniGO3qEpj63oKGcX/wpYCHNlHwkjLuAe7llg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6B65XMUJKhB7skRw+Qal7pHz/cTVyzjF1abWCtMjUQKEIyTsKQgznZ43f97kDuTWq063eSUcCIjIZdgbW44OAlH935/Wj+yH6UHXdq8XcXYxFet48Q8JsbOCZHF7Apr3fus/zG16a4FstdEI0ndoI4OztoNAN/aJabQ2ATKc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC0drX2k; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33e4fdb8so56759515ad.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745339967; x=1745944767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PpE6QdE75qx3JQiGFwCJlKqastRY3fkAhIF5CsFNa14=;
        b=hC0drX2kdOqV84PoHEWDcHZl/JuwTKflfxTqyKtX9CBgi7bSQ0DyXaNdwB56ONa5ID
         WwABuu8q2rXR5gRC9gk0SA3e3VNAjpeH6ni7Uj1uUp9FrjUsT87ShE05Q3zN6VZ0fykc
         XAZznc/hOc1v/fTHF9QxMayuCciWKQz1m8gEsRiAXMjWzUsfF00l9MqE8030haRpvo0G
         2GOSn3j/0/HCigU+yf3Te0F5fC9zQJBEc1rXJSZdJMu894WdyJFInUSNLTg/NT7n7L9e
         4Pb/37nZfwFonP68p0R0R7i+zuXmEpagUbGr8hdjVIaQ8v6hBMDSDMWnKiw+n+zzD4gf
         vaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339967; x=1745944767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpE6QdE75qx3JQiGFwCJlKqastRY3fkAhIF5CsFNa14=;
        b=XeEwnDkE9IXySip6WJdgaF9TrrcGHmM3NRMDdlg3PFtlCGMXoNkPjHYraTNaMjT1C3
         vpNPXisulQzQAgsdER2M5rOR13ijBzvGGTmtxU5whuDvizySPf4F2LtqaJwnvavVaOgs
         yECe61vS44671UXD7d1xkGNDUE3w3tcDGprB3VpJLSqI1RMzHetcpJ6pdEHDyqtCd2RF
         X5VTmtHE5QyPy1/+9z8ge6glYdQALTKMTTzB6bJOXr/QSKaW/5I5ErByb0/p7fQLj799
         pgoijgzW8oJB/xZzsAPx6bQVeF1xRdRc9ssMHfDQw33Lq/uVZVxt4NnDIEcIXgS4ZYGw
         43Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUqtuzRjf/2+Emp5dCe2CKDAdxJyp52tWOv5G6VeV5enYBC3VHrxT/y+aVRiuigsbcxg4DVMP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7F3pfb8CNDi1axdR5Go+l6LCWegJf7tsndUnaQaTMy+5+fgb
	M4E9HIve3XSbzp8l8ss17H7v+XucJwGZSMZ8M1dZMGlJ8oxJ42o=
X-Gm-Gg: ASbGnctJ96pvK7tQ8+hpLekWa6JPyK83hiWYZK1ZiwdUJm3BnAzl0GLFtXHarfD0cA8
	pc3/aoVWNnPG/J6gy6x1xYnlBpI7bYDO/jp5Ewu1gTi1Betv7OBT5igo6m2bDpzFVJnsdcZANVI
	jbSt0K5j2Z0QIwjE7213kTXZlgJ0MC/jG5HVOq6R+4wCIHOUelVggs1EIkPExR+gB3i2vpc7MU/
	53KgTEAq2GWp4uUa4Rc4+0sVWHeDalKCxP60DSr0ED/P/fM4ANMcb2SIqlSmg2HQohb4P8/DUbO
	Qs9MIfMK2fH1SjkgboQvAP6ROJBvMqRP3nV53VGC0IKmuYzGTO0=
X-Google-Smtp-Source: AGHT+IFO6SQsSslLj4X3n9gvFhaEVB7biHRsSzWgmJ+TV/IvtFHTd9cldS31QLUOLIHx/mYCPa/90Q==
X-Received: by 2002:a17:903:3202:b0:220:faa2:c917 with SMTP id d9443c01a7336-22c53611075mr252058905ad.34.1745339967554;
        Tue, 22 Apr 2025 09:39:27 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50ecdc9csm86824885ad.165.2025.04.22.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:39:27 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:39:26 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 21/22] selftests: drv-net: add helper/wrapper for
 bpftrace
Message-ID: <aAfGPkfLhxhAN1N6@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-22-kuba@kernel.org>
 <aAfFilVul0zbE20U@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAfFilVul0zbE20U@mini-arch>

On 04/22, Stanislav Fomichev wrote:
> On 04/21, Jakub Kicinski wrote:
> > bpftrace is very useful for low level driver testing. perf or trace-cmd
> > would also do for collecting data from tracepoints, but they require
> > much more post-processing.
> > 
> > Add a wrapper for running bpftrace and sanitizing its output.
> > bpftrace has JSON output, which is great, but it prints loose objects
> > and in a slightly inconvenient format. We have to read the objects
> > line by line, and while at it return them indexed by the map name.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  tools/testing/selftests/net/lib/py/utils.py | 33 +++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> > index 34470d65d871..760ccf6fcccc 100644
> > --- a/tools/testing/selftests/net/lib/py/utils.py
> > +++ b/tools/testing/selftests/net/lib/py/utils.py
> > @@ -185,6 +185,39 @@ global_defer_queue = []
> >      return tool('ethtool', args, json=json, ns=ns, host=host)
> >  
> >  
> > +def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
> > +    """
> > +    Run bpftrace and return map data (if json=True).
> > +    The output of bpftrace is inconvenient, so the helper converts
> > +    to a dict indexed by map name, e.g.:
> > +     {
> > +       "@":     { ... },
> > +       "@map2": { ... },
> > +     }
> > +    """
> > +    cmd_arr = ['bpftrace']
> > +    # Throw in --quiet if json, otherwise the output has two objects
> > +    if json:
> > +        cmd_arr += ['-f', 'json', '-q']
> > +    if timeout:
> > +        expr += ' interval:s:' + str(timeout) + ' { exit(); }'
> 
> nit: any reason not to use format string here ^^

Ah, probably because {} in the string...

