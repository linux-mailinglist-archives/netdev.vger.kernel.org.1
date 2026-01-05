Return-Path: <netdev+bounces-246982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A758CF3288
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 12:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B290F3025F9A
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADF221D011;
	Mon,  5 Jan 2026 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqeSUgs/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1B3195F6
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611062; cv=none; b=BBCgbxmXZ50WzhBubvaGercc2GlScQqRjnu2Futb2xqLAEs1ndoYVABLyHbAQ1SPbIwuFzO+HEDg9LvUjB+e+pGDI1E+SEnOU6/2lkYGS1atuI7UFkjueWOzRNBf5UKknkxILogh9frDNYo2bMGuv77Y3OCvGh3JfOMfw7vfwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611062; c=relaxed/simple;
	bh=pSQjuOI9wcLr08I8TyNDVDtZ+plM1hk+1WUrJMqKsKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIT/148U/AkrB+QrJIICeicll4ZGPcEVWIQpaNBJNrfR2DoOUMlpGl+IZoXYI1M0INy7+lEZIWGGfmq3CMtA1l30qsChYJFLdTVtYW3sJOW2Xfeo9D++AoX8v6evHiSNul/hWKEeGfqnHftVUqdvamccnze09ctxoJYUnMyjcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqeSUgs/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42e2e77f519so7938386f8f.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 03:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767611057; x=1768215857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gp32gXZBzPi/+owIIcw+ejy/cxTPqGdSU5O8VFJVUqg=;
        b=DqeSUgs/AY8NXTj6tcgmuDC0oiqzBAghqD1pWz8w4QEOTkTGASmr6K3MK/LpKyhGhE
         DqWPRYwk5boNpRN7HFmhYgyBcTWyNJDGENPUg3m/zdrMA9Gs4YVr24x3rL/WykEOQvs+
         PNpytfGxyhQ+SbVJZ8gkCkeL+2E/IxPpMZSRyC17Gfobe/fgvvptsIDTYknq95Nc2Y18
         OxMYCnLaIRELBrBn6fk0upyeiGkeJjVMsgzPwDdpxY6+qQ+fEkT3GwM96A33wu2DgsoX
         p7sB1x43KjjgdcacyXwkNXBQQlxM6A/xCC7dg5O+jtzzZISPWkRrnQwAi1kF8HPErGMB
         lPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767611057; x=1768215857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp32gXZBzPi/+owIIcw+ejy/cxTPqGdSU5O8VFJVUqg=;
        b=OCCHTPM9S5sDF3lXBAt1VE4G42pIQszzTUiGL5Pb/xQcZTuYq1xQlsu0zbgBLP+bAM
         J/Z5kMxtyqWTSQQ38C7FQvWRTVuzIEPiImH3cqGEq5OEkxuV0CcWlBFohlexnl1Xpa42
         0JipGxmwcSXdR1tHIwIdHKkVwRP2JB0hEURDFkBxo0lIh5V6lnLUe+kl7Zr9n1yuDT99
         JaV2a7+yK8LqXoZu7LYivEM5bSF0LUO4uC86RLf0Awp4M30C6tZ3/MW6FFHbAcO+Q7am
         vbViCJNWNoIddCQ+mwG0xbTHmM6TXYOckhxdP7jxJ/f7gGb1CVBE0acFJax6ThkV0bFS
         jPew==
X-Forwarded-Encrypted: i=1; AJvYcCVy7YW3sWsIb2UwSPAk+7DbyHocx0JDzJC14bqYPq3FYqJc3JD9g/Op/UDQkOKo04sSu5N5RkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysT2S+RZSfpmW1TdXRs9Y66kk0hU7Wce+AtQlPCStL8GCsnG+G
	df2hV8ChF0DUKNAugiJBAZfieSvUD8W+0eDyKmk2o8XK7AXeUDGBh7ffIWWr9Q8QBg==
X-Gm-Gg: AY/fxX6Nyn92TIzFPOyVP9O2lurzpNLBSxDXOAXXv88OUuM/5cg3MSZ8DE1dSVHDfV4
	piRB6Y0ljRkFJZIFFF8DBSeWl2Z7krk7DDSctq9BapkzxaXwqESTrxCZyKeuiyF2xaco/4A6a65
	r+1eYvyK3GhcfYLbajDq2MUJOvyL5tD23/vFNxTGHAzbUQ4p8BIGvX+xePCCR7ggrVhYFInfb1D
	9hrR5qo/MAMq9B3hYDTNm7H4Nnqm9NrvxqmzRwqJ/l0c67x6GzdTSVI7Z4k4RQEmpbmLOOm2j08
	IsRCmvD8Y06l30Xe5ciU3B4xtfxWLCkRcF6XQ4WtjyLCFicx+prKksSoT4xpIVPGGlCq+H6cOMc
	KrxLlHinVnDDumzYasS1T/0aMTd9UlKrtsKPTZznXDNTRsaij19eTYykqg9sMdbciXXEC5it2TU
	5nj4efNfcjUpOBf1Vm/Bh2DfYGz9njl5gnGudP8Ve7wdcyjKaNTkSz
X-Google-Smtp-Source: AGHT+IG9vrBLNBq0MW+dkviHnF4LAt1RYyyrv14vSAjsaEoJzVASiZBHgrBaKHVi84I/vsKswUQRZQ==
X-Received: by 2002:a05:6000:2c02:b0:42b:4267:83e9 with SMTP id ffacd0b85a97d-4324e4c73f3mr57556292f8f.2.1767611056658;
        Mon, 05 Jan 2026 03:04:16 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:8034:c3df:e486:e883])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea22674sm101510889f8f.10.2026.01.05.03.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:04:15 -0800 (PST)
Date: Mon, 5 Jan 2026 12:04:10 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Message-ID: <aVuaqij9nXhLfAvN@google.com>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>

Hello!

On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
> On Wed, Dec 31, 2025 at 1:33 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > Motivation
> > ---
> >
> > For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> > identifying object from a policy perspective is the path passed to
> > connect(2). However, this operation currently restricts LSMs that rely
> > on VFS-based mediation, because the pathname resolved during connect()
> > is not preserved in a form visible to existing hooks before connection
> > establishment.
> 
> Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
> and security_unix_may_send() ?

Thanks for bringing it up!

That path is set by the process that acts as the listening side for
the socket.  The listening and the connecting process might not live
in the same mount namespace, and in that case, it would not match the
path which is passed by the client in the struct sockaddr_un.

For more details, see
https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
and
https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277

Justin: Maybe we could add that reasoning to the cover letter in the
next version of the patch?

–Günther

