Return-Path: <netdev+bounces-179884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37920A7ED10
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47A5424D70
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90582221D98;
	Mon,  7 Apr 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wru3J/Fg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561A2222D4
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052645; cv=none; b=KAm5k0F0z2XnCtRapActueoGoMvkPKPBp5Dn4v8ZQgb8hfa31Xt22eCdTBSHprSm0gH8So1hDjOpdSPb/341ItrT46HxlvRG7lT1ouY2ChIl3Pk0ghmkaGUjmD1qhX5p93osqcfJfDv2ektPSjlxfgm0ytJjh0g1DEH2aEEeU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052645; c=relaxed/simple;
	bh=Pm7uV5pfVrn+fqNuY63WVLzH+Z0MWN3zZ3Hq+12UjPE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Zad62h9HAg42sGonWXW6Lls2p78umNq1xO1KNp24lsF1HdcqKjYuYz2t9Pg1pZAMYiat+t8boJplhptd+7O+P/IP8kDqlojvyDvs4LdwMXtS7hVPiLl8KrTZSxB6pDwn1nureg6F5Z3Ulf8HpX3zWtcSc8WE16tgLF99NtXB1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wru3J/Fg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c597760323so424694285a.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744052643; x=1744657443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmQkaKfknMj2obvtWYonx9tbA2RMTZd+jmr5zMJiijk=;
        b=Wru3J/FgR/orHyOUHDb7TjQOsztgm54UfImMCyacAQs3RnTbC+rycOnXXj2F1uyUkI
         pmaSLf6MJaWDGO1TNBiTy4ON6KysTSJKQUhaUaqagDYAI4zD1mquFwBzeavJO7pvPbr0
         WGXaVpYat9RffE9KMRQf6NDMrwAyg+wDQWlnC1VBTqXhPquW3mHMwpG04+f4yibYKnBP
         tKOCn2XA5tK5wAFlZSg6RbwV+GCKkC6CruWhjhsA7nMz306tmyEDH9RJo0bGKxD9Rr1l
         MlmrTK1MMlPgV7KkjwzRkBbcyxRopW9mPsCzeVtdDKwJvNBy44AHekSvFGS1x6+yCqgQ
         nIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744052643; x=1744657443;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OmQkaKfknMj2obvtWYonx9tbA2RMTZd+jmr5zMJiijk=;
        b=dPNnc2UHgd719E+XAwuS13xrrlSAxbb/fFbPob9YKd0k8vcXr+FVCYOfXDVurxqIQc
         JS3V41BK7J/WYW+VkfQXFPYTTSvHeTqUDHPNjDAQgwu16ej32u2J3SGzkw6ipygD19DS
         Dtgx85O397ucLAaxV05fDcXi5F6cNW5YU4y7ISyn/Rj4fSMa7rD7Lhk1FtVjidR8ACdY
         t2QWbGTbsi3ZXMjBW3nI+Xh1IiL6t/Qe2j5UsoDBtjzZZpgZc3Yo0ekvBROU0zwSGrGD
         0qIVfEF5DBIpjthDEhiIJA/o1KzF4nT8AcQ3ZYKXlRqx8m3YYcbx4qZyk4Y5vzHf0I0t
         Uulw==
X-Forwarded-Encrypted: i=1; AJvYcCXc9r9mgZpr3CXlYfVFORGZBZ6Bb6tGPPDP32I28Oa8uahKSGbcVmvUNSPX8fqNPc1skIqluVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyldVDhxdMdqj/hU9pMn5Sm+zmnew0ES2vm7diZrjZymUi00XjP
	gsSiDPYPJOd4AVTu99S9MGzauvvKX2a0SsJabr0N/H1G7Zrf+VtP
X-Gm-Gg: ASbGncuAv177zZCAYWbH0KSG8owrT6bUoUPKIJyDFRsi7VzV4uAqq0aWLPZNQ+MehFE
	nbTOWcxcCEOfUKPPI33JwpYfHknYAwJHSg9/kf+7zRBWyHLWK0csMKs6ftANMJSE3jRWyqNKaFc
	uvEDTthv4wLVBWKvs3dOW57HHFCHyJZhw2JrOHWm6nCaxMWCeeYjsgYGs3RWcMUIDjEHgmwjQ8Q
	r3+YNOPSLTrnJGFrvtW9ieJkpZSacXlCRJjpZDOvoJ8nFMWiA1WQ2dAChTHDjadoeItj13mYFVv
	o5pDkce5qIZrv5qorUf7q49LYJf63M997IuRUcEB+Eopc7gbQHy5r16bUuPStjXySMnNbvp1G0/
	8ssflvcMdXW8E5Y8vz3fM6A==
X-Google-Smtp-Source: AGHT+IHWqdPY82z09hKkdEz9v2ue//jMsGYysj3tydGjEyzCU7Xgq4MRCCET9FMfVrdi8zgEq7RUZw==
X-Received: by 2002:a05:620a:f04:b0:7c5:57c7:9994 with SMTP id af79cd13be357-7c77dd814b1mr1409224385a.32.1744052642822;
        Mon, 07 Apr 2025 12:04:02 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e96a1fcsm632662085a.54.2025.04.07.12.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:04:01 -0700 (PDT)
Date: Mon, 07 Apr 2025 15:04:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <67f421a189e15_3a74d52948b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250407163602.170356-4-edumazet@google.com>
References: <20250407163602.170356-1-edumazet@google.com>
 <20250407163602.170356-4-edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] net: add data-race annotations in
 softnet_seq_show()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> softnet_seq_show() reads several fields that might be updated
> concurrently. Add READ_ONCE() and WRITE_ONCE() annotations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

