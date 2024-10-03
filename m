Return-Path: <netdev+bounces-131700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC098F4C3
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49F8282960
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4801A705F;
	Thu,  3 Oct 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTauaz5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36EC1A7240
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974965; cv=none; b=oYjkYGpYpTMeAq++BmL5Y8FXe1jPY9bTf5OUkq6FKZ3xdQI8ckDZNrhlU8DY8jkj6x15xevxjoSg+9Em1jnHHMTUzcSxU32suagfHq8hK1iSH3WrOENgxFuC3kU3eZHsR2Hn8Ubc4gg3HYtj5uFjTGdhTInW9XMSjBY4/s+14WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974965; c=relaxed/simple;
	bh=WrNqKr8q4Xm21d/QASbgtr8hmtvQHYvz7aVzh4QU8v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psddSGPVz+Y8k1zPLFKfoMaynoNzOoXemZsxN1v6/FgsO1rARpDK5ZtZHU69kkiDJpEUXK2zH9u+XhSKdFBfCr0O6eNZWWmXYmDjuwWzFVLDMls34TSYp56Aph9pelj6IIhPh1WAYIQXEMHpPQxUzhs71pq8dtKdHWbRypO2mTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTauaz5C; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71970655611so1193151b3a.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974963; x=1728579763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S/VJ0DZj2GMl/ato4RFwBvYZWfzbiQvi8swK/lCHH2I=;
        b=WTauaz5C81U/Jd14M4+8QDqkUTKFILrOeZMSAle+I+uu1+PGOyQ8geWFhfzAPAwrWD
         hc8O+7I+OnqpJXsxCNAxbC5OzYNM3zejHsQ91wT6Tl+i1SNhE5Zkc1+Q1TFWCCs9y6MO
         F/ONGD9n8jRtsSRWcOtGh/162KBJRLUSiCVjpzv7NxxoYeZ7iFC4fEED/BJwVQYNa2Vn
         TJHmkJdqi9eVPFwr9bXThJVFAuGQ4HyOCw65yfuz11khi2yo7e59f1GRdEbntIxftERQ
         vW58wGOXU414qU0biVu33j9wUBVz67+gcDcNZE/PLuaEo9AG2uWrrURvq0aiwQAj5KGR
         iqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974963; x=1728579763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/VJ0DZj2GMl/ato4RFwBvYZWfzbiQvi8swK/lCHH2I=;
        b=mG4G/yRIIE9i1Qn5BqV3tVZu9os+L3cE8YElTmkARLeKdvqTY23OpkDuqg6tylFDgn
         RsQpMtaucHm3FeVp7UMpaOaPanGtzLdJbRrWSFoENK89xL5RDUxU7kET1gemSpf7jUmR
         zPrYB1EeOpHKCzN/I2IOlUdRyRGJD9BMtiGCT8xxaqpkRsVkme8hZf6Zo5kbT7MeNTP5
         92W3iPJ9BTuKatAvYtVE+TTHBoYXVCHuyezf1wb77uyQlebFhBec+M0NOglhMO3KpCd8
         3T4sJ4fMTTDq2SGLxt4cY+WWWLbWlA9d1PE5puyhfYErEot4j+yE2xrP02gdWZE7i6UH
         Hr+A==
X-Forwarded-Encrypted: i=1; AJvYcCV/AaGvJV+TZhRQ4IiVFlqitNFTvRDCKuWXO2xupHPTrhxqStWtfVlKjUZ6U95pXeDMIOGajb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+EsJMXbAIz8ACROvKEtUkQNRJj+JWAOPRUOeovvCWMj5Y1OWk
	feBmbGByeKmH4/yi2bEmHcP5dsUFL9LWFNi9V1iNSbsRvXUzNmk=
X-Google-Smtp-Source: AGHT+IGiTTBZyooHN2wvBLnwSpAGsWWc7FMsql44aQN4RhmDkhmOuhhRRZb3Q1XlBoufsK9xfTTVCQ==
X-Received: by 2002:a05:6a00:21c2:b0:717:9768:a4ed with SMTP id d2e1a72fcca58-71dc5c8f95bmr12504294b3a.16.1727974962819;
        Thu, 03 Oct 2024 10:02:42 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9df03a7sm1572205b3a.169.2024.10.03.10.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:02:42 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:02:41 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 09/12] selftests: ncdevmem: Remove hard-coded
 queue numbers
Message-ID: <Zv7OMcx2yff-QSO9@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-10-sdf@fomichev.me>
 <CAHS8izNK+DiQUUkkvnPQvBRJiQ32WRO0Crg=nvOW9vn_4kCE+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNK+DiQUUkkvnPQvBRJiQ32WRO0Crg=nvOW9vn_4kCE+Q@mail.gmail.com>

On 10/03, Mina Almasry wrote:
> On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Use single last queue of the device and probe it dynamically.
> >
> 
> Sorry I know there was a pending discussion in the last iteration that
> I didn't respond to. Been a rough week with me out sick a bit.
> 
> For this, the issue I see is that by default only 1 queue binding will
> be tested, but I feel like test coverage for the multiple queues case
> by default is very nice because I actually ran into some issues making
> multi-queue binding work.
> 
> Can we change this so that, by default, it binds to the last rxq_num/2
> queues of the device?

I'm probably missing something, but why do you think exercising this from
the probe/selftest mode is not enough? It might be confusing for the readers
to understand why we bind to half of the queues and flow steer into them
when in reality there is only single tcp flow.

IOW, can we keep these two modes:
1. server / client - use single queue
2. selftest / probe - use more than 1 queue by default (and I'll remove the
   checks that enforce the number of queues for this mode to let the
   users override)

