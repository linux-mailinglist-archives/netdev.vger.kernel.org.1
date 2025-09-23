Return-Path: <netdev+bounces-225534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF41B952E1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01251684CC
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EBF3203A9;
	Tue, 23 Sep 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxkKrRYF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFED3128D1
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618783; cv=none; b=PSuAtrtnj9K9NJXAhDt8PK9g5ZsqnIl5IhHE/pwJjk8mRso/QRXCNFd9paAq2I/LLwVYhXc95SCYgiXCQeni3a+gEE7nwODpTEUPLqsFdH2d59K6igaeIh0IosCaNEDvOpfzRzBn5SgEJ4naFKCUNvkuGZFlNMeh9OQ2YHtTRWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618783; c=relaxed/simple;
	bh=Z2IWOFXhly7czGdlFGv46kWBB6KEbOpImNkHcKF2Ygc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BINYeNU6xLzfi6khp9QdPnjyppuRISsJfTOHpzg1c4kZdAnYiSInh04Usyis1fAtXjdssCqeRG/JngrHtXgmsq7a/yhmAwTnJcVrCmm62OqflyS4B1r0o6CYz4Wf55j5BFUtaz86gpNvjFtD37rTomppINMyZqGnzH2cx5xHjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxkKrRYF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f343231fcso923230b3a.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758618781; x=1759223581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5KSUsAM+a2Guq01/UCd+zY46Lp+YhJNLyp0jhG/Hzg=;
        b=JxkKrRYFYwO2A6yfsIzpVctoaJL2iGrCn/R9nqUR7HOx4W7ptwFRBO5d1GzqpwiwhF
         4lLLvJQvbQJgu4euSlDlLmdzFf7eC+iGw7y86YXYOlCCgsN8ftn9fwrXccpvUzwrHBCN
         Vv1vY2BDTusVl31p0yU7iBGG4XM+UkGmWiDpI69kROEYNJJnCY6ZCSnkzAFvWgWBUEhT
         zzZ4rcsDH9cbwqhMqqXlCgAPoroAvkpc5ig+Y2IJp0cOWfW++G2BrqSgJAI/HOo6NN+t
         sZz7gMFFkgE0k0tw6EyYi2e9X9JxvyYpIjT4I0wDqoZOh33G5g38JgsNxc5q+lGvTqZr
         dzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758618781; x=1759223581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5KSUsAM+a2Guq01/UCd+zY46Lp+YhJNLyp0jhG/Hzg=;
        b=i0bXSlfr1qxy8OtxuWrFXKs/HEdIe7OvfIm3c2phmLiZlzqKyOOb0WxHkdw7afvVJI
         Aaixpsku5P74bit/iOTN8ZwWMwQMdn3lm2on/tkIbeKyvhUZpCjlF8Le1ehdrXngfX1L
         8+Jcyl5+xHT/W0UcS2R29l+vgFtSGXYufWRpK0sxMhx4Gz1kLKeS89J/bqheoWZ8YNio
         nHbGoWjzs6lU8NmSSDjz7JSP3T3JtlBvIEL3LKCbR1riBd7ZvGevJIAcWgsREQXl4HQ8
         2WxqFBkD+5W5ra0y/45gHBsTChwb3YQHE4danWh2Pi+wyzDCF4nUKmlPuI9R7WmZ2DBG
         UoSQ==
X-Gm-Message-State: AOJu0YyKU4pWM49eGji6d98ph/5IqSVjBM5agMdQ8fMzxhZBjbXpQ46b
	UPGiSMdNDmdUWbnO955SYf3QfXWL/jMe6SD2/JFgCpjxaLTEsSQIvpkf
X-Gm-Gg: ASbGncubDo9WB+BJmbZkpLZCFzKq6QdCVdy5uMEhP2uNvWimi92ivvNDw6FLnPglYTy
	VAN385RsccTSjNuf3MgvQjyegSoVIoBcVqVIUQHYkFyfYCVfVJayMJVQKF48ZKPURqZKAvd5nJK
	MCQ85chztdp/Qp1h9VC/sYGppzgeq55DSJ5vwJhzmYNzDrqLMwTgB4i7VWfh0VZQ03lN+9IutOM
	1u8bNvSPbUxQ8lTIQhbm/xZ7tEjXJTd4Zkz4NRQSd9RLFzctZFE7vSEOOLN54FHWnImEKXyZkST
	NfTdolLaulsJZG/+6l5jI3vWeioXXWKeXqw5s1A6kojbx6/HyyXvxRoPvp4NGGAIStzdcdRWh/H
	iGXGTbSHWosnczjJiZlg1bwxlBZGdRdMACIrEFQ==
X-Google-Smtp-Source: AGHT+IG4lZcyzKZit/zs68rwxqzDaPk+kvZqWCucgdIMMrCFwODAl/U5RUgZFN3WUiVGtFCWrZc7ww==
X-Received: by 2002:a05:6a00:1397:b0:772:7ddd:3fe0 with SMTP id d2e1a72fcca58-77f53855c3bmr2456640b3a.2.1758618781501;
        Tue, 23 Sep 2025 02:13:01 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f363ed5a0sm5646616b3a.41.2025.09.23.02.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:13:00 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:12:53 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net 2/2] selftests: bonding: add ipsec offload test
Message-ID: <aNJklbSInqqIkfK9@fedora>
References: <20250918020202.440904-1-liuhangbin@gmail.com>
 <20250918020202.440904-2-liuhangbin@gmail.com>
 <ae9f772b-d1fb-4688-a809-b4507060d205@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae9f772b-d1fb-4688-a809-b4507060d205@redhat.com>

On Tue, Sep 23, 2025 at 10:32:22AM +0200, Paolo Abeni wrote:
> > +lib_dir=$(dirname "$0")
> > +source "$lib_dir"/../../../net/lib.sh
> > +algo="aead rfc4106(gcm(aes)) 0x3132333435363738393031323334353664636261 128"
> > +srcip=192.0.2.1
> > +dstip=192.0.2.2
> > +ipsec0=/sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
> > +ipsec1=/sys/kernel/debug/netdevsim/netdevsim0/ports/1/ipsec
> > +active_slave=""
> > +
> > +active_slave_changed()
> > +{
> > +        local old_active_slave=$1
> > +        local new_active_slave=$(ip -n ${ns} -d -j link show bond0 | \
> > +				 jq -r ".[].linkinfo.info_data.active_slave")
> 
> shell check is not super happy about the lack of double quotes  around
> the variables (above and many places below) and about declaring the
> variable and assigning it to a subshell in the same statement.
> 
> I think it's better to address such warnings for consistency.

Ah, this is a patch I wrote some times ago. I forgot to re-format it with
shellcheck. I will fix the warnings.

Thanks
hangbin

