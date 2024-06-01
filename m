Return-Path: <netdev+bounces-99950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542CB8D72AB
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F516281395
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19222F1E;
	Sat,  1 Jun 2024 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="aeoaWuxt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D338FB0
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717283418; cv=none; b=Kq35ibgctpQ8+9BE0y7MKQuVyQBIzyRukluoSjWv2HNZUcVt65aOiiIhRL1nlNS62+6wCiss62/He9142y3qeWNmZj/Fe46oEVSAfdRnnsvFRsTmqkN11cL4T+54cKEpI/tXgBfTwLTcfab8gQN8bCytCnyblFoxqs+uo+4SFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717283418; c=relaxed/simple;
	bh=QSzoC+J3evxRdNx7jjZB+Optb7puke7ZZvRp3epTuRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwKPIjgcgmeTkrX1jQDcqo/dTCDgosHXS4O1lyqhuAaHLyix/rFVSFFFJKl/HtmJXOTl8bqLE0gf+/Jv6E2GzKcywYQiXjZaCvyAALYlK4OtFbN1iMfJKhwz49Y8er3Vj4UAtA33mxzFWCPV30bRUx6k30o2SNRhmJQ264ApJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=aeoaWuxt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f6342c5fa8so14910875ad.1
        for <netdev@vger.kernel.org>; Sat, 01 Jun 2024 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1717283415; x=1717888215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbSov62WxJ+FXZ1blI97jG+IhmcO8chYp/ObclCZSe8=;
        b=aeoaWuxtnjoJzoFYllHs9ayWhWe0y+2B8/iWDow/ugz2CuYMDNcQpXT+USM849Avr2
         HMNhiDVt29oPx+rEMZB4Zd86ap3QTAsfDHclWoOlkPhTAmQ+pZDkGXG3LTCbYWjKfvJs
         1WQ/eYrCPgo3HDNtT5U177DxSCHmGSFkD63ysXSHYgY44+83CVul7esGKxX+dj1gSFf3
         zFh14rPhKKZee3joOdotGhMz6pYvJynIxsmg3lvbwTE1CRkSyS5GP4zQ1ILftqNbhGfB
         wyW2zAPuf5eJtALlP3cBOPXPQ1VWEmvqWNIlRkfWYjldH4CQ/ti6xp4ezO6/hLUwvtXz
         IeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717283415; x=1717888215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbSov62WxJ+FXZ1blI97jG+IhmcO8chYp/ObclCZSe8=;
        b=ucB+FPvkqRXbpEPeZ4k/suFnuYbVB13H0Y16LsPU4zHFMlm+L4w8L+cJTxgZc8zcBq
         BmTnyjwfrE3DLvg0wK2HERTABwmcUrzqRaPpu6qcHG8+H6d9IhOPkzytKryAmPwHHnXN
         nw0BsncrGxPXwVB2ic29K4+tVNf+wFVXqabmdhMGA4eizS1YWyJSE6mMexohL+lA6L/N
         xCD942U1W/71AqLj34lNcRBcKQ7gOY8OSGue24uBcl5nfcTxmw8r39L7z7RpFvtr5fuu
         LjZpb/JYaBQfnP9sj2UJODQK19kz3x2lzAOZR59c1FBbwfmbhjzcDQ2JGYrrkOdEfk+5
         I2VA==
X-Forwarded-Encrypted: i=1; AJvYcCW60cMSJpLKpLdvFnLCt1b8aNNAL9loYmvJ+r208Ouxsy5D9tCWdCWK3MtbralrGjJOkEdqwSrLAUnI3aeM61vP72TFuNLz
X-Gm-Message-State: AOJu0YyZi5BuTR6h2iru13YonMeAjZqV99w9+CPp3JK4r2QU6/n5JAJK
	wyzahbGuglyVOQ1+gDr6kJUHYQvNxcBRgFQGLseP1qeLLeysNb84iXrOcdGV+Ng=
X-Google-Smtp-Source: AGHT+IGw0N5rqwCb8FqnWNnIKbOOUCe/SmbxbHRGe+lbs8z5VLZbJCSFzhZhqNTBqIxCC1wJcSQWBg==
X-Received: by 2002:a17:902:ec87:b0:1f4:9e9f:57df with SMTP id d9443c01a7336-1f6370b1249mr71046035ad.58.1717283415487;
        Sat, 01 Jun 2024 16:10:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241ad60sm37889105ad.290.2024.06.01.16.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 16:10:15 -0700 (PDT)
Date: Sat, 1 Jun 2024 16:10:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 dsahern@kernel.org
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in
 inet_dump_ifaddr()
Message-ID: <20240601161013.10d5e52c@hermes.local>
In-Reply-To: <20240601212517.644844-1-kuba@kernel.org>
References: <20240601212517.644844-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Jun 2024 14:25:17 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> + * When used in combination with for_each_netdev_dump() - make sure to
> + * invalidate the ifindex when iteration is done. for_each_netdev_dump()
> + * does not move the iterator index "after" the last valid entry.
> + *
> + * NOTE: Do not use this helper for dumps without known legacy users!
> + *       Most families are accessed only using well-written libraries
> + *       so starting to coalesce NLM_DONE is perfectly fine, and more efficient.

Sorry, I disagree.

You can't just fix the problem areas. The split was an ABI change, and there could
be a problem in any dump. This the ABI version of the old argument 
  If a tree falls in a forest and no one is around to hear it, does it make a sound?

All dumps must behave the same. You are stuck with the legacy behavior.

