Return-Path: <netdev+bounces-160769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1975A1B4BA
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 12:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCD43ADBC5
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68111CDA13;
	Fri, 24 Jan 2025 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbAxYdI3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A918218EBF
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717879; cv=none; b=W5IPovp/l1N8bqUSE0OvNz0PkuqX57D6QuCyD1x8ch0qbzAev0Cz8fyA4yQegkTezcI+JbyA3XijmEqjSc+fEs0BjxfAQXSSsrMWHVS1FFyfdJsVHSF7nj+MUWZ54oqSM+/Y5XHcLlhtaqmyyXLplasDd3mNFa0IUY51cjh70lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717879; c=relaxed/simple;
	bh=kDuUZXJmeXA51UBrn63uNfG2QS/pXJjHl08qT6Zu4uQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=HN6ToXHDom8Gem+TNJXlxOQzOD1tdbLOP4ge3qKzgPPypzFCqOX/W0nA0aZvrjTgQUMh8W8R/TDUFg4XGhKs3xIZCZtpQRbxW2CJ/d0N/1YnoNA2hT0UWoPLxlaVJ68yXjnTFAu2rBw6qsRlfSYI1s85V1btLy3veFllqOT/U40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbAxYdI3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385d7f19f20so1012095f8f.1
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 03:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737717876; x=1738322676; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPy9qyDJpaJ6jdQ6zGTl4Fsuqnzlt6Gz6CZ3k3QS4WI=;
        b=FbAxYdI3OU/SPx2OY6qNr1GXDqoblodnbsXCVegADDOMlxPxp6DCrO63rmsKPVVKFL
         p4ncy3a3v6dEdQasAmjH49H0rFiDuYLH8ehiOYWL9Qa2+mf9WJhhfKH2uspL/d+Tcmsd
         Qnse0nCNoIyS9HC+3eqyrcoCD5s6LfMCaGRN80mJ2RXE+oiagVXbHQgAyIMFvqKDTVHC
         7tzQ12txejaEJ9+Ul1U1Qx+5ZGZpXjXlLEd0Ch7OannJYOAMGGRaGfuv8hTHpnYFtYUt
         HF0V/SRcxuen6GZ33FdagfsxES3bJJntTJ8RNktjBsDtL3czvjCbH37zCBE1Q8LMx00s
         dv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737717876; x=1738322676;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPy9qyDJpaJ6jdQ6zGTl4Fsuqnzlt6Gz6CZ3k3QS4WI=;
        b=Y/n/Sy219HoSz6wWcVCDSrk/CePPbOOs972KfaL1QsLubYAThND9F+VnCa6a+XDApZ
         v1vUXWAeR+0EVamXwv2/URzBjmNvu1x7rMTq1/0HPRtHoakfWjrULZr5cCF6L2GvQWfx
         3rlC9XWKZE4yUuHO8NFYap4HY9WVKOJjaBZXSJfZ/uub7CoMwCQDAt9KU2FpZiEbqD0e
         VzaDw/ClAcyEGJtgytamRKhTHM24phoJKQfX3bE8aVboMvboZqfMxss5xslWuwK6sr0n
         JHB0l1W+i71UZI/hXm4qigAEzM3H9FCkETNVej+sVZNrHUcPIWPVPJwban1p42wqSoRe
         b01g==
X-Forwarded-Encrypted: i=1; AJvYcCXNrrcPbkm2GAhnqIdKopKZJIwPLZYBjdLa9kZSD8RPRf3EsXkgxd1muP/zgNsqEA/Y1QgGG9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Aho47Ov5XWSBFxGVk9oS617mgoxnNCeuy6VO1qo8JExg0ZnP
	UeIFbsvpVQqSd7nuJoHB3jxPEDWLxFG+iXWXqXjWvngp7GV29IFJ
X-Gm-Gg: ASbGncsm8yX3PyNc+xp+37fTXDlY+erF7xgvvMDBys8TBD2v1Nz5f/UgR/gr50nhAAA
	Yp5Ie7EqMS3a64jRlnsXPE3y5uVCeF2QvonLYC/Fe657u5Ny4c/ZgaWZ5qJCh0hme0f7tnSINne
	bWHgg0LKZfsjQhbu28HcjS/cqBhDfuwp9k+1VxYFPui1lSH9k0jFKb/hDdLQc5+p5G76U3XaQ6S
	5SmiRXkY+mXicjAjE64jL0fqOiVCvSQPO8aGGauvfuHE3th1DXp8/GEjdv+189xv+0ATr0FZJ6s
	8VSYMgOhiEdTvTfS
X-Google-Smtp-Source: AGHT+IHJFjlZxwPoOjzdYBBlyGxsNGawdKoWCmEDm5p/1jD7n2o5qQBtEuBAht2hHb/sB0bOQPeDAw==
X-Received: by 2002:adf:ef8d:0:b0:385:f060:b7fc with SMTP id ffacd0b85a97d-38bf5674b55mr26339936f8f.25.1737717876221;
        Fri, 24 Jan 2025 03:24:36 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:df9:ce59:11c1:2a2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bbb39sm2406293f8f.65.2025.01.24.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:24:35 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  nicolas.dichtel@6wind.com,  willemb@google.com
Subject: Re: [PATCH net] tools: ynl: c: correct reverse decode of empty attrs
In-Reply-To: <20250124012130.1121227-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 23 Jan 2025 17:21:30 -0800")
Date: Fri, 24 Jan 2025 10:17:34 +0000
Message-ID: <m2tt9oldmp.fsf@gmail.com>
References: <20250124012130.1121227-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> netlink reports which attribute was incorrect by sending back
> an attribute offset. Offset points to the address of struct nlattr,
> but to interpret the type we also need the nesting path.
> Attribute IDs have different meaning in different nests
> of the same message.
>
> Correct the condition for "is the offset within current attribute".
> ynl_attr_data_len() does not include the attribute header,
> so the end offset was off by 4 bytes.
>
> This means that we'd always skip over flags and empty nests.
>
> The devmem tests, for example, issues an invalid request with
> empty queue nests, resulting in the following error:
>
>   YNL failed: Kernel error: missing attribute: .queues.ifindex
>
> The message is incorrect, "queues" nest does not have an "ifindex"
> attribute defined. With this fix we decend correctly into the nest:
>
>   YNL failed: Kernel error: missing attribute: .queues.id
>
> Fixes: 86878f14d71a ("tools: ynl: user space helpers")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: nicolas.dichtel@6wind.com
> CC: willemb@google.com
> ---
>  tools/net/ynl/lib/ynl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> index e16cef160bc2..ce32cb35007d 100644
> --- a/tools/net/ynl/lib/ynl.c
> +++ b/tools/net/ynl/lib/ynl.c
> @@ -95,7 +95,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
>  
>  	ynl_attr_for_each_payload(start, data_len, attr) {
>  		astart_off = (char *)attr - (char *)start;
> -		aend_off = astart_off + ynl_attr_data_len(attr);
> +		aend_off = (char *)ynl_attr_data_end(attr) - (char *)start;
>  		if (aend_off <= off)
>  			continue;

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

