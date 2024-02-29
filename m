Return-Path: <netdev+bounces-76263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E486186D089
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A041B289077
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BA56CBED;
	Thu, 29 Feb 2024 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jgn0PoCh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750474AED5
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227579; cv=none; b=SwadiLLXP8VcdDa5YhsYqejtDg58QASx4WNyPPGDBCkh9sU3MBJe38xHIbo53oozLtN15xQXqjGH5BPRpeUQtDClafW0O1QLzL8MxPVHLtuQojnqMJIRqqFc24EiiJDpmq5vAMlf63M23KrzF1OXNJM4b6Rcufkntq0JL3xtjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227579; c=relaxed/simple;
	bh=Etjtbbx4NxPd5N9d0BidkBmcMFHSibJGgj//TEuqK2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=egxE9tmCLgofo2odMWBDPhaBqkBZlu0YlnmCtnDVkgB5otH8f4eTtrJfXBzO+ZthdqdMOZ3dYKkEbYigxcJpWS3tFHH7CPp/e60jfm9iid5IMKOApLHkE7Rap/Y3VdmYxew4BU4W8z35Q2hV/7+nrlaZ2hkFQ8ZiNNfViLRuiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jgn0PoCh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6087ffdac8cso17117947b3.2
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709227577; x=1709832377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9VD4cPqpsg9zimf9hplXMHfBc51A5d3Vm/Xebvlxm8=;
        b=Jgn0PoChncgEIWYhEpTLq9S6g8dH0geeZeUqq/IVe8w1fv9RokjY3Xr9hAWJQcIHoh
         Yi4el+Re7sJE4AWTNBSg5NS+Z/25/fQ5ay5W3q1v8MQwIEGTreSAOsWg/uo/pSWkXaIW
         ClzIbnhVgDxgmkkFEpmOA/836O7eau315h7gKCAqbT/si307HaWlRTyzZXBEIyWhY2ur
         caYrxLqfLxcO1HZ6uhUhGuTY6tLkyLGYR3KnR2cboP5oqP23gisTY8ubUUMLf3ZmrSKF
         YPEdghSMc71jj6mTdkJXUNHWzCxt6vMgzh7vxT8WgcsPOpyrH9pZmAe63s7i46FKmAFp
         nWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227577; x=1709832377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9VD4cPqpsg9zimf9hplXMHfBc51A5d3Vm/Xebvlxm8=;
        b=aPmEzXVofRRGJc7Xolh9F8h13TTCc8TD4nxco0boQ7xqvPDKIW3KorJwT5RL8NUveA
         p+VdW/rAm7Aq4CkVlWiK073WCP7uLLCm5Aq6E3P0jxhx1EcF7GjlcwHnkk00hpiPF43L
         DHquAQzUAnKklRZIbPO1cBJ+J/iW/cid/ycsbUJqhq3zT18HnDdxJsWZaRwIUx6zIhOU
         Ryap4jj5kS1pjPXb75wCn8Ej5TcSTKGb6POs50bjJwgqm0x00mj9zKNKvC3f4w9OFxit
         Z8E1BtN4tw/f4pzy/+rXZ7jtfnmM9JRJaIvzREZm93Sc1t1ljh4018TBNkAkEHatCsP6
         wbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdebW+KjCll5sV6L67uTBsBoeWouRgROgxbbvmdAy/objaZ1vp4c72POcyhxqRQuxlB7wEGCuWXeO+KgHQagOru2xLdVYJ
X-Gm-Message-State: AOJu0Yx3wbqH5pg4VTqIJ3o8RbNtuB1unz6NMfCsaBLGbm60jr8cYR2l
	azyF7DLoA5AxkkdUiX0KKnu6rV0aw24HARGfPSKG+DxYUPNO1dketFY8sybMiGGxdQ==
X-Google-Smtp-Source: AGHT+IGqQjb+7nyVtr932AJb8D7j8iwOrz6LxWnq8Fy4ZIVBQ5VtHU7/JYPQXs5YSQCdW4WqtC4e/Zk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:d45:b0:dc7:5c0d:f177 with SMTP id
 cs5-20020a0569020d4500b00dc75c0df177mr655298ybb.6.1709227577590; Thu, 29 Feb
 2024 09:26:17 -0800 (PST)
Date: Thu, 29 Feb 2024 09:26:16 -0800
In-Reply-To: <20240229010221.2408413-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229010221.2408413-1-kuba@kernel.org>
Message-ID: <ZeC-ONC_JsmAJlN9@google.com>
Subject: Re: [PATCH net-next v2 0/3] netdev: add per-queue statistics
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, amritha.nambiar@intel.com, danielj@nvidia.com, 
	mst@redhat.com, michael.chan@broadcom.com, vadim.fedorenko@linux.dev, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="utf-8"

On 02/28, Jakub Kicinski wrote:
> Hi!
> 
> Per queue stats keep coming up, so it's about time someone laid
> the foundation. This series adds the uAPI, a handful of stats
> and a sample support for bnxt. It's not very comprehensive in
> terms of stat types or driver support. The expectation is that
> the support will grow organically. If we have the basic pieces
> in place it will be easy for reviewers to request new stats,
> or use of the API in place of ethtool -S.
> 
> See patch 3 for sample output.
> 
> v2:
>  - un-wrap short lines
>  - s/stats/qstats/
> v1: https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
>  - rename projection -> scope
>  - turn projection/scope into flags
>  - remove the "netdev" scope since it's always implied
> rfc: https://lore.kernel.org/all/20240222223629.158254-1-kuba@kernel.org/

Acked-by: Stanislav Fomichev <sdf@google.com>

