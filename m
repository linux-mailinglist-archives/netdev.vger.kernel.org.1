Return-Path: <netdev+bounces-114959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF2944CE7
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457751F22021
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F36196DA1;
	Thu,  1 Aug 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHkww2oM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C41A0722
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517952; cv=none; b=imWYwUuJXWPaOGUsL8iOgaINmqvZBIvWsu4dCRCHq6NLW02pn2tBKPbx1dVdE2f04S/wgElO84l0fxnLEv8MybWIu9ubWyAwxB0O/BMkp6jQZMQU1Zg780AusdDkBfBmT+gtaDFcI71kXvkxRW0tSdCs6dKjwIKO2xypRE0ikGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517952; c=relaxed/simple;
	bh=3bp5PKPWIssd7f28x0auv3vMQ1hpxw7TK5cuRw+hpQE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZyvZ5P6oeuNgEU9GNvX4DUNxNffvcYq/JE9pQLLsH8A1cRhkSXQlSTk7Ayj76+VBFqqzffeZc+8+T9wIqEr3dsPCa0wINc7IkgJfXK0gzlPYBsYuiYvtUt4cIwnyFOyBr+faUYNJdk5Q9TM/eVTP6ndGXOhAWR3bEr0voA5vOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHkww2oM; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d0ad7113so471074685a.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722517950; x=1723122750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVxCDDEBid5wqktJeMVVXEDqnEp2/eHP6hf6rHvHzL0=;
        b=jHkww2oMJBIxlJh44UrP+aMINKQv9m6dPP5K8tH59N3dgMprg8SiJ3CsKy1RaVRPas
         G32Syk85h3z34Tu+aLSHOYiFcx3lZiLGEfiMWiDBtLHZB3c4OZF8ekdRv/b2ca+ji+IL
         A860v/mGpIZQUQVei/Btn8J8YYgw2r72wTdqsFioYcqjAC/30khizmtextffejBfzh0g
         DfLfZLUpWFT6cmuyCFra38HN1Rfc1ABcywkbDHFcGRasdNwf+Cl5zeAbGLHuJ9QEAvem
         krofX3DMT4OFMi96+cnIY5bO9A798CZGbO5VEMRD5GB1Xs8pmQMWiRVf9lACv8wvrKL6
         PwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517950; x=1723122750;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eVxCDDEBid5wqktJeMVVXEDqnEp2/eHP6hf6rHvHzL0=;
        b=WS3r8K8OxWwjq3Z+ulFRW3UaDDGvwXotBLLE9O0uaRs9p3T/uI8ezHMtz/TZBdbx8x
         J3jLt5+DBe+47d0DYBZTqf6t2bO57PAfZ4umGHETmXqBCPdY6yiOt24qkIkQn0Y/yAkz
         7u+1b7U1Tn82cI+636WtIeG4sPayzC4D+sxCbm4LHnyZaQQAXCYayn3ehYsx94S0Ouzt
         WGG30kjBjwhTEr73uK2x3OUP0phSkfiDXfBXyeQL2u46q/lN/SLyviqfjsXwi1z4nmt9
         tqVAmTVRwGIzCxKoGmfEtepo1gsJmbrCcSh9BBqwOXKfT/3U1mTtb+cgsWxxtG56cEkX
         vSlw==
X-Forwarded-Encrypted: i=1; AJvYcCUNNhWkSRBugsDbvxmyqcnJ7kYdB9vrxXH9XiLUVCVUnAjb6yI6C/V9Hh+uHKgvtU8kjw6A7Gdhc0Raupc7yuV2e95/70Us
X-Gm-Message-State: AOJu0YyB+1kBywqnroTdp1yHU3sejYM2kW4eIne8WOR86mjFPw9ZkMJm
	sMmeJMrJJw9Khhn9V/7e+Qir+WV5sNwnK65zzJ20IZNBobpYOCP9
X-Google-Smtp-Source: AGHT+IFyRoc0BtEhIRhDBVPIRsqr9//HikSHPPvVFqCdJcDcm8C6U6UgDkiDfDGy0dVdmlidG5j6nA==
X-Received: by 2002:a05:620a:44c4:b0:79f:18d4:d613 with SMTP id af79cd13be357-7a30c67f483mr274118885a.38.1722517950021;
        Thu, 01 Aug 2024 06:12:30 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a20d6426f4sm150368485a.8.2024.08.01.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:12:29 -0700 (PDT)
Date: Thu, 01 Aug 2024 09:12:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ab89bd18f59_2441da29413@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731172332.683815-3-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-3-tom@herbertland.com>
Subject: Re: [PATCH 02/12] flow_dissector: Parse ETH_P_TEB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> ETH_P_TEB (Trans Ether Bridging) is the EtherType to carry
> a plain Etherent frame. Add case in skb_flow_dissect to parse
> packets of this type
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

