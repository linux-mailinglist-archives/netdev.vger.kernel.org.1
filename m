Return-Path: <netdev+bounces-167199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A0FA39214
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 05:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC723B1C5C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 04:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805B8198823;
	Tue, 18 Feb 2025 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hARR5iTx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E4157E6B
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739852520; cv=none; b=FY94rbE6mQ1jsCWk71erlA2XTbCzAIz+Xzg3ZJ4mnMiRd4yom9AdRUoSI+cSXqtysRxq0D+n6ZSmdiCkIR5hzOWzmzlr0Cl220UpPMF9cZWmh3nmHH1RKZSFufoAkbQdd/o2GLmU9NFUjNhHecDQ2jlNke+m4RwGc6irHWkG2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739852520; c=relaxed/simple;
	bh=xXDwfXLddBcj1J2Ji5BkXt5VONXwCDVF+Z8fZFVA4CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcb1Go/58rK/SgpCIlTjnM05JtBYQi231QiRjXuS2D/RfgbHkFltN7mnXRxNpmBARFYf9WfnZuRjPpT2f7Qma/kDHuei2JFB+cohovYifArQhkCygz2IkhxMWXcQz5UuPXpUnm3xwwtue0To9cdkZUq77fKBV//tmlZBrDJkhts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hARR5iTx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so7152487a91.2
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 20:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739852518; x=1740457318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpBtlq27elQMyWHP/zHOhb5yNessQDc0RV+l3FHvYO8=;
        b=hARR5iTxkaiOXGKmXOUAeF7lyQVQuIs42SGT2OcYnipMa9ilkPl/h8diT763wUdXCD
         yBN0OtJ4SLRtSo65o7riaNtDrT3+q1GcbxWGbMhz/lO2H9k/D2pP9yNLehb7Xqol+O48
         e+kICZbHIzXQpgR6MmkBYeUr+5FW42bF/+sUs0pKNMAr2K5XNIRawRiW9Z3JIYNGKdVe
         OuIbuISFst64NA/L8i4UhEABtvbcsDbx5YNbRFRx1vADsPOydMcWZxTiuxJXIpPlALa3
         10r4eSg+ald0p2Cn8k6+N2H6FQXP/noyxXxZ13H196WRE3rHW04YpHkY7Pph/MJYMnv5
         b4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739852518; x=1740457318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpBtlq27elQMyWHP/zHOhb5yNessQDc0RV+l3FHvYO8=;
        b=d+wz0s3oKM6RQyQ8ew6AsIhIVybQtkl+EwexLdL/ol68Nv1g1xdwuTc2XhovY5j6uI
         t5O/bAwR21ifZA4dBe8ecyI4DE/wBMK0Q7i0fFD1qBXCYuRwoxehpwcoQk1uBiO0HUdq
         kPV6/RdtAwbApQZepXANpl29qse0QEEazCYQqh0fNhl/lUaxn55J7ceXz53nl9xguJ/3
         528hLsxFRdMKkkak165Mq+hN7lvH+1Olaer7tzKAdNPqKo0JTKwuU8vIwbspfpLYxBBD
         H1nR3xIJCgdMoejIu3fzj5cuTvT6KH6IlLUdQE9jfd39fkFKH6Y8klQxM2kckF6DQx8K
         Pp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvwe67c4NxEzHJWdH7WzlmPe7+UGoI0C/ZDvBHvv1rHFD36XTknmCpkgOLlAWqQXYEzkhcawk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG17IDQKu26560A3p3IEtI0EMkWKH9giXKotodPjNbQ4R8k46G
	4RjWt6UGZKDKJ6Am4EyddGaQ1hoPdNIQMoJ4swPeGsENc8nokxA=
X-Gm-Gg: ASbGncuEfIUbpNopsG3eM4pkAxsYBckXznNZYA/cOjYzjGfs8i+aE66sqhkMX3qkpA6
	+yGqKQ1YJ8y2VR081qe2JMUqqeGdHCJiSZHPBQtNv6bfNpfXhMfNhbyz+oL9gMc24fwBtcLbUwt
	6BNCFj6yy4SBFckog2DCcgmr6K8OscgKLudmmKFwtFK4+KFWHgeSu3v9L6ERDjcvttxxRZHYYmo
	ri7EHSPncReJfcVeGzBIv1XnieVM3tGBmIDzNaUbeluoUn+0LwHySkDe++hcCX6kHsH6nTT3Jm2
	Wv6qEEzG2kjTMtc=
X-Google-Smtp-Source: AGHT+IHVwMf8yaPlApGHtGVDobcQBnKRGISogR5ShgN/NJ/BhtAd4ieTXECJIAZ55c8l8Ywwbo3+lA==
X-Received: by 2002:a05:6a00:124f:b0:732:5935:c219 with SMTP id d2e1a72fcca58-7326177d652mr22474339b3a.3.1739852518078;
        Mon, 17 Feb 2025 20:21:58 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-732782dbb36sm3374493b3a.57.2025.02.17.20.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 20:21:57 -0800 (PST)
Date: Mon, 17 Feb 2025 20:21:56 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next v3 3/4] selftests: drv-net: store addresses in
 dict indexed by ipver
Message-ID: <Z7QK5BBo-ufND1yB@mini-arch>
References: <20250217194200.3011136-1-kuba@kernel.org>
 <20250217194200.3011136-4-kuba@kernel.org>
 <67b3df4f8d88a_c0e2529493@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67b3df4f8d88a_c0e2529493@willemb.c.googlers.com.notmuch>

On 02/17, Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > Looks like more and more tests want to iterate over IP version,
> > run the same test over ipv4 and ipv6. The current naming of
> > members in the env class makes it a bit awkward, we have
> > separate members for ipv4 and ipv6 parameters.
> > 
> > Store the parameters inside dicts, so that tests can easily
> > index them with ip version.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> > +++ b/tools/testing/selftests/drivers/net/ping.py
> > @@ -8,17 +8,17 @@ from lib.py import bkg, cmd, wait_port_listen, rand_port
> >  
> >  
> >  def test_v4(cfg) -> None:
> > -    cfg.require_v4()
> > +    cfg.require_ipver("4")
> >  
> > -    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
> > -    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> > +    cmd(f"ping -c 1 -W0.5 {cfg.remote_addr_v["4"]}")
> > +    cmd(f"ping -c 1 -W0.5 {cfg.addr_v["4"]}", host=cfg.remote)
> 
> Here and below, intended to use single quote around constant?

Let's kick it off the testing queue as well..

# overriding timeout to 90
# selftests: drivers/net: ping.py
#   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/./ping.py", line 13
#     cmd(f"ping -c 1 -W0.5 {cfg.remote_addr_v["4"]}")
#                                               ^
# SyntaxError: f-string: unmatched '['

---
pw-bot: cr

