Return-Path: <netdev+bounces-215551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BADEB2F2FE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295A61899226
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BCF2E8E12;
	Thu, 21 Aug 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZ6ZQ8CL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E792D7809
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766433; cv=none; b=mdlBYLAoqpCIQbQoX7yaLT70XJ3XRcbFX3/nx06pZMJM0D9bVrRGI0rvEdqL7MDZXezvNbwwMUSORlXk80gvnUhuVM+JBzx1TZ1zOYrE01CTPAbaUhKtjkel0WI1VT1IBZkEEPFRTtMYQjSsugELotqLfZWjM87e5aLWxpMFvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766433; c=relaxed/simple;
	bh=aBhzP6d3YQDrwI7ND5rpwO6HjIyfUepP/sZomCKrjm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1JDOoQCfJNMpoV429LgJJrn0y7zEXNUkndiNtnZW0BmSnJl8p91P6YdkVwvDcuO6TqZv5NaCpiO06q+/yz8PYHy04ZLqRQ3anqOx9/34G4PLgrwKUnV5gNnic92bq6KjvERS3Gtgd9Hnl9h4Z4REHcqUsSUGvPjmdd+kk5W3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZ6ZQ8CL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109921fe7so9230021cf.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755766430; x=1756371230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBhzP6d3YQDrwI7ND5rpwO6HjIyfUepP/sZomCKrjm8=;
        b=gZ6ZQ8CLB54J23MX/pt7FqW269gE8bsMDwn21mPtLT1bevECMXpZpl21m1w6brOzBu
         oD6kz2uLAhFXuUSa1JYnGDvF9Zlm3WtzvlcetMDIrjNtJ0N8w6WeE4ioy+2F2bq4Mwg8
         FsI+nj+q/zSl48nemYBRa4/Z8uUOB7/vrRKfzt5bkWvrb04M0tqPX1r4prY/Iss0AMs+
         6T5MhmhMbywueAOuCjOS4vHAwZDOcrkq2nm2esudyoTgS0uBf2DfYxynGv6Dw7XH8VG2
         CVzWYtowqIDYUI+LP/UQOdn6KpiezjhugF9HtEkJ3YEULL2oQ0eXqKeg08ILMfKcLP/U
         rXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766430; x=1756371230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBhzP6d3YQDrwI7ND5rpwO6HjIyfUepP/sZomCKrjm8=;
        b=Yu3QviNE6fnAquCArZaG6d9BxOef0YU1Zy9fD9FPECv8etYdDoHh9vHKEmVeqhg4Na
         l+P/wOfRbLEq2O2n1eDio1kVBqeqCiqQW30ThRgnOFUYxXhtWqxKoQTo4eJPiK3l4D8n
         We1J1MKYiZLwTwPRJF05QbGPDwd8tShLNeQVZWAAisl4xo+4cg3rmelUgVlACcO6pcVZ
         u6A4AreYey1NCXbrAx7dLHj1vTvmscD8K2470QRTwKxvZjDJjHDfgIPitewc4OE7bnzj
         ZdWX9e5FosE9qcK4/sStQfT/Z1ggM4w08Q+JYJHNj1YSWIeuP2OakjB4zjvXg3xgFnat
         WHFw==
X-Forwarded-Encrypted: i=1; AJvYcCV1k5e3Fhjy3bD30nmveEBtwZA1JMqRGKF85T3N3341cwHzG38wr++9k//iGquOWJ6xzufkHhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPgWnLr9/DogqRBPJDd81vn5KOYQzciWymMTRqitVS8HeqPcSG
	4JvojO+no7Uj93SlVS6n2DusiU56vXYmlCeM1LOvhjRaQePtgNv17aVWmulqerrXLmRbAhWJhSX
	G55CFPmlGpcG87ct9QZdqWclw++RefqnwC3wOb+58
X-Gm-Gg: ASbGncupMs+0kaVFbdSBU+hW/nFY7y6WvOC7GK/z/drWj0QIeXntpjGBsR9xv48R6r1
	pZpVlrtqKu2+6z9CTcw+nXqb2WMIjKqpri6qJrxcX0/JVPF5eV2It5PptXWx6G26c75Bo2JDevP
	sbmvk8VtJrsekaMyXKAgBnoAKfuYsqlSWFPAd3qRbPpvz6U0KqedsELgezI3bQ4B3XHCp7VlkKC
	MHs2PGld3fG0s7XKMdQfgQ0YA==
X-Google-Smtp-Source: AGHT+IFv/PtcOPUQj2eIhfJGxSY/JvZ2K28lWNXCVsP0qeHLxlQhiCXLQmPIYrOD4LLNF/m/ke6DWecfHMX5teVadAA=
X-Received: by 2002:a05:622a:1115:b0:4b0:6836:6efa with SMTP id
 d75a77b69052e-4b29fa33f1cmr12068061cf.17.1755766430147; Thu, 21 Aug 2025
 01:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-5-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-5-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 01:53:39 -0700
X-Gm-Features: Ac12FXyHsFmM4Y6s9A4jizpJZU8-dSIL1pxwxTNu7e_RRTYEAUIKywp1b0fLC34
Message-ID: <CANn89iJn24y7pfqOL9unDK2WX9wjVwTRXjsY0ABdHtxQzexS_Q@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 04/14] tcp: ecn functions in separated
 include file
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:39=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> The following patches will modify ECN helpers and add AccECN herlpers,
> and this patch moves the existing ones into a separated include file.
>
> No functional changes.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

