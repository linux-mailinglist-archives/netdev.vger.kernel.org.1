Return-Path: <netdev+bounces-143453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A90D9C27A5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 23:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112B7283066
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D7D1EBFEC;
	Fri,  8 Nov 2024 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC8fqG/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572851E0B67;
	Fri,  8 Nov 2024 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105485; cv=none; b=kyynE7mpT6M5hxMutcex9zXyAHsA3vhIaRFYqUbfvRBsHEBt9lLJcEyE6YRYi7XOexo5g8bl+x6in77g01J52NmzbdBWqdwKq6VXqWayGJ31oRXeUcfz2Zyvt3qQbQFbByMoal4AFdt/OwL8FIR1r/6xq4/kWgeUf3reSmxezp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105485; c=relaxed/simple;
	bh=HG/Z4aeyO39LhZI4pi8ETl903UTWXgOSj7cXHjFbK7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKlPlAbHF15VSwlZZotbI/adOwnvv+Ml2MWkiewGhmqIIwzQk90yjkZRzmC0j0Gcx4rnhNiCGKuIgr6kTPLZBhLaNPA2PGMsYJFYQOJl0cgpfY7TBGJ3AGJCmsI0RjejqFhR/r37AfG+Hg542l1e/52SjHSegjtmZSlfd6SVz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC8fqG/R; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ee53b30470so974026eaf.3;
        Fri, 08 Nov 2024 14:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731105482; x=1731710282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef+nuKAweoLnQLtJWrC9nc5IytkziH8wSsoYPVks8Jo=;
        b=YC8fqG/RtWfMD81sz7B6jIlUv81M+5V9zaW4Ch+/3tL3DGvjNIrtVDq+hx+A0FdwhW
         uFfJU6LfUWRfQofDBH6IzEwX78q/vy6h06eLQ+J/l6ZrulDWCAOYqPY5iWcz4A0hQxfV
         39ku1V6moK1WJPdu0AqpxcVPC46UYeaPzkYDYrppuTgv3KLfeTh/9a2jN8J05sqMnCA+
         EyrV5eAEvR9F/oU8ymEhn/a4/Hc7kDcKorttYGxRXkM00mv+Pf84Vg+vkzXit/moWUE/
         EusId5y+IY8NQ4UZ/t9HrYRQZJ5RxGED+5MSb32TftQO+82CQHL3DAqg/zPEMI3BwrJJ
         cY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731105482; x=1731710282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ef+nuKAweoLnQLtJWrC9nc5IytkziH8wSsoYPVks8Jo=;
        b=p4g5bkZOM+t7bGi71374dNpQ176RbgJMO5YSyf/3FYXthk0dLDeJVuiJbLjlvn58WI
         PUhzCVfTuzc8hslwjxQ/aDfNLSPaxIJx50UnFNYZm1k/xa2cVVDTmfK3pMFPVKSd6TQx
         b1mWRw/btDNwnJAiq1rqnx01avqZNeIXgLiEWaJOJKDu8Jr9Vh3cdmyUPhLwXBSUDWu2
         uIsYh2DtcU3Jn+mM4CbLDb0qoD1AfBmN4NfKx2cYv06gbuQYZAqlD7wQQXUz1sSjNEbA
         Ebtz1x5cVUZDWyjQ1nNmxB5PlJsl0aYx3Gj+aVsiZdu018dfIW2W7DM9I5k9Y6n60po/
         ZcqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7B+XNfuRd3Y1Ae7Mz4O3smf9TRpz2wM2Zg5IOdTIMf8EB02iWtPmG0y+k9Jkky8uQSr9NcEnA8HHz2y7G@vger.kernel.org, AJvYcCX8zjL7og2RKMpZtXNuOdkIT2ylPPX5gMYlORMe5F++WZKB/X9YTE+HNqhNuPjXjG4eOwpN1eiaAok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI7oEeM/I8pm5l39XJTNKopn3YVnWkDhmc6rWjoBsGHMa6VXJj
	+lFv74s2OhX1kzq1hMcCW3xwaSVOgvHpo6HdJsQ3GrFT+223sCDyS1+DlEk6t9baoOhdefdsk5d
	C9/NCWhy8nvaVLTxXz35zhKgJRA8=
X-Google-Smtp-Source: AGHT+IFw6L6MwIPVpm5m/vqu5nv3hx0uQ5SgPG1RClTH3XyEoMn2m2/XX0pYOfOXJO+8xyxYfL3hQETyezKTEt3DEME=
X-Received: by 2002:a05:6820:1e85:b0:5e1:d741:6f04 with SMTP id
 006d021491bc7-5ee57cbee48mr4056662eaf.3.1731105482352; Fri, 08 Nov 2024
 14:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107020555.321245-1-sanman.p211993@gmail.com> <20241107102044.4e5ba38f@kernel.org>
In-Reply-To: <20241107102044.4e5ba38f@kernel.org>
From: Sanman Pradhan <sanman.p211993@gmail.com>
Date: Fri, 8 Nov 2024 14:37:26 -0800
Message-ID: <CAG4C-OmPAqNe2RHwgBZ9+1MBq48bOOLgDdFnPiRyPz6Duy15nQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] eth: fbnic: Add PCIe hardware statistics
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kernel-team@meta.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	corbet@lwn.net, mohsin.bashr@gmail.com, sanmanpradhan@meta.com, 
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev, jdamato@fastly.com, 
	sdf@fomichev.me, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 10:20, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  6 Nov 2024 18:05:55 -0800 Sanman Pradhan wrote:
> > +     FBNIC_HW_STAT("pcie_ob_rd_tlp", pcie.ob_rd_tlp),
> > +     FBNIC_HW_STAT("pcie_ob_rd_dword", pcie.ob_rd_dword),
> > +     FBNIC_HW_STAT("pcie_ob_wr_tlp", pcie.ob_wr_tlp),
> > +     FBNIC_HW_STAT("pcie_ob_wr_dword", pcie.ob_wr_dword),
> > +     FBNIC_HW_STAT("pcie_ob_cpl_tlp", pcie.ob_cpl_tlp),
> > +     FBNIC_HW_STAT("pcie_ob_cpl_dword", pcie.ob_cpl_dword),
> > +     FBNIC_HW_STAT("pcie_ob_rd_no_tag", pcie.ob_rd_no_tag),
> > +     FBNIC_HW_STAT("pcie_ob_rd_no_cpl_cred", pcie.ob_rd_no_cpl_cred),
> > +     FBNIC_HW_STAT("pcie_ob_rd_no_np_cred", pcie.ob_rd_no_np_cred),
>
> Having thought about this a bit longer I think Andrew's point is valid.
> Let's move these to a debugfs file. Sorry for the flip flop.

Thanks for the review, I have submitted v3 with the necessary changes.

