Return-Path: <netdev+bounces-247552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BCCCFB9E0
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 576A0301F27C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEFC10FD;
	Wed,  7 Jan 2026 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bew6r3E5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1662147FB
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750202; cv=none; b=ntldxh3bkqfD5DGbSt1cUcil8qgDkxN+G4PJRE9wGjNSN5kqKAi2RYV9S4aFNkVNjB2yvyTw9+72blwqVyrK8ZCl7zJLtPv0vykHYF5sRPwV7InNcagZ/PjF87Nuj3+iTYGNvIBlLHiUxEDvDmqAR3S/HJEfEIJr6wAdSLwHvNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750202; c=relaxed/simple;
	bh=M2uqrvbW4Fn7XOeF3WfWXWJVTdFJdIeQ/8fM5iG72cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIPqvkLzAbDJWm8dTFrX3abydTxkLJrHCjwhgjXevFZzM+H9q3nzxsh6P/QDOBNfrSH2y02EIOlM1sp4xCEcKVb4wAiHYyBh20AMgLt8zOdJTzx6TIsKfuczssg4UG5lNZU9D5PFSGHRQpt0K7Xzm+GzREY/o8gRL3qYeZ+8S5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bew6r3E5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso1487772b3a.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 17:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767750200; x=1768355000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4522piqQtaIQiHcLvE0ibRXU9y0l5+dEQ/ID035eGEY=;
        b=bew6r3E5U/RNN/YhLFsG9WS9O8zX3ilOByasnCtGrRrjSVycDoswvSI+bdGfkE/rlw
         RdxhQ87zGcqIdxc/6V9Rh7AH876dJNDiIslRxV0DVfXdE5mBnfTOmwmKq4WGHi3QN6jV
         18KzdH4wJ2sleeDKMl9+SpOh/BTAgwrIwCOanSEAwz6x2kGMlOC/TI5nrZogF722JXwo
         2HKKw7bRdamfxukPL9cnus51J6fGYZgB/nRIR1RX8c4CV3iXdWjDJepIuxdy39ni8vG2
         qag4gpAqgWYbEVFATLZGKY5kkCND+btDlTEcbGo4kpj8i8qt1SOvMl/khLqRCHZltkCz
         jg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767750200; x=1768355000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4522piqQtaIQiHcLvE0ibRXU9y0l5+dEQ/ID035eGEY=;
        b=HkrNozwm54tqcvmIal3Ei97IfSz2G6AP3bmmWAOloQzV2Kin1Z8MOSbEUNr+nka17Y
         JyFhAHbYc9Jzf+prvyPQd8JoMe8EDlvFwBwimeIVXM2lCiRDHoSwDz/sRBTs7mJfjgen
         Uy4qefbeuVfe2M6Brb/9iryo3Oaiat9T8Ott3urWMM60GIRfk7C3rtezHjKqMHUpv0L8
         /BH6YO66LIrhLogJuVIzdHUfVHQbmw+2XbqIT8EJSXP5EMLgKK5EdSzm13dSAG/uGpSW
         d49nbulGQH8JT6IYkIq6L0ly/RtKkdz8VSflKozY35cHCHCLhJDU0Pp7nbiQUMyFXwsQ
         f+mw==
X-Forwarded-Encrypted: i=1; AJvYcCWqIqX4UJgCJhJFZhejkg50CtyVgd4hbXSlDy4oPmJwLnVtqmvCG2aqbQN29SloBjhHuTdiYqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKcZ/YJ2F79rrsz6gChuZTmT1yRRB/lzjGr8V6+9fF43eSRJL
	uR6PhlVcJPlN3N4mLee3GB/gKId+s9r60P6wIaX0VTfcC/HVece3qwES
X-Gm-Gg: AY/fxX5DDQ5JHSDrhKmO1OtLpCLG+hZMhvMcaHA5erYMOASyGlFDndGdzZHcA8R9ciH
	G++y5D2Bo4BgwzgFAafF2lkqYlPKXPQReBGB8TbhBNlJCHWzR2iMUCFV8I+06CTUVy0LAQSIX0q
	pu+dluJdkf+j5DeXPIC4gYar6zxmf14mJvbp3I90YMXqKoDC/xEn0I2Pl4gpWdPFLrj2JR0GQD7
	nNGwn0jq/13dsfdlVihCLCCn9c2gwK9O3XU+nJNUSENgr2wequONsvZT2r3K1wwYNCgrx83GaNn
	yre64gH1Qr5teIl96NVSL7rnWmr2N8ciDmrSJAyss6p5v4Zje8A1GdU8bw/MXKKNU4/psZoaBYB
	zGA7BsRXhcUegINk0QJmt09GhiwFTtmY+Fk2FgosJIu2pyAym8oHzuCEOjFkgnOcB+HHifDk+zP
	L7FmTWLLBrZbF7OSA=
X-Google-Smtp-Source: AGHT+IGRdsPcZ7cDAZV9mUq0+ioBCVAqycotJ4oPsRikbFb5TGAVNYw7xRxbJ5X/88n7qNOs0Fk7PQ==
X-Received: by 2002:a05:6a00:e15:b0:7e8:4471:ae66 with SMTP id d2e1a72fcca58-81b7fbcb6d5mr697682b3a.50.1767750200071;
        Tue, 06 Jan 2026 17:43:20 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e7544sm3167879b3a.50.2026.01.06.17.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:43:19 -0800 (PST)
Date: Wed, 7 Jan 2026 01:43:12 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, jstancek@redhat.com, matttbe@kernel.org
Subject: Re: [PATCH net] tools: ynl: don't install tests
Message-ID: <aV26MLdSjkE6bpMb@fedora>
References: <20260106163426.1468943-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106163426.1468943-1-kuba@kernel.org>

On Tue, Jan 06, 2026 at 08:34:26AM -0800, Jakub Kicinski wrote:
> make's install target is meant for installing the production
> artifacts, AFAIU. Don't install test_ynl_cli and test_ynl_ethtool
> from under the main YNL install target. The install target
> under tests/ is retained in case someone wants the tests
> to be installed.
> 
> Fixes: 308b7dee3e5c ("tools: ynl: add YNL test framework")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jstancek@redhat.com
> CC: liuhangbin@gmail.com
> CC: matttbe@kernel.org
> ---
>  tools/net/ynl/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
> index 7736b492f559..c2f3e8b3f2ac 100644
> --- a/tools/net/ynl/Makefile
> +++ b/tools/net/ynl/Makefile
> @@ -51,7 +51,6 @@ install: libynl.a lib/*.h
>  	@echo -e "\tINSTALL pyynl"
>  	@pip install --prefix=$(DESTDIR)$(prefix) .
>  	@make -C generated install
> -	@make -C tests install
>  
>  run_tests:
>  	@$(MAKE) -C tests run_tests
> -- 
> 2.52.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

