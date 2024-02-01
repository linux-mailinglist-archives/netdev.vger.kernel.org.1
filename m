Return-Path: <netdev+bounces-67907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97B8454F7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 11:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD3828F3E4
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0034DA06;
	Thu,  1 Feb 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="trlXLoeg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164A15B11B
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782445; cv=none; b=K2TXmzyNZ/wHliT9XypQHo/TQvr6I4jaSzx889E7AJXAsJz2zD3yk5mNsprDWwYXdhw70AIVScLQELlL97tlDrv0sUaoRo2wYk2rdI4rf8NQylB/ZCBZGjHu08SgdAOrvSF9Q8dSrShAt0TD8Kkt5r8U11xohXMn4qj2Uz/D8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782445; c=relaxed/simple;
	bh=ZI5RtE8zkA8WP2I8EFMXwgAhBsml9b7wPVyfiO5m79Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWIMh4zlPIE8vypoFAgS+KpLljUCzXyjaCQnKNsAHbwQa6N68rQP8Tr7hqApI8ApLc5JA6x7NWiCRR0gK/1lD+DS3shMChusxpWu/R3/FyGphw6tMNwUvo6ciR2qi7FqcUJKS4WUK/a9P1NtKgP8fnQoPZuU3CmAzOzUMdfKZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=trlXLoeg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ae4205ad8so487734f8f.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 02:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706782441; x=1707387241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/e8HqGTBoNdiXvpZKyoPnEwDs0/fPJqWhKv8bb/8xc=;
        b=trlXLoegtcC/CkHT5KGqreesF3ZcRu7OEsT383AGqRQOLwRYgIXoj2XQMtbmjKcQ4G
         9blXK/2ObWhAYzlohB1vzo/Myil1ghZEGi9/D8zEwcJQ+rml8hH1tLwcNX7WSgatxvwc
         gm56vONmCx/aqt7zD/dVcE+a5qUI9zYNWuXY+XvARmGb0olafIgkUl1YGdcOU3nT5nR8
         oF0WRqE5MjT48uPeu/zS2WpEWyO0jISHuqIBxkJhzClwol5EkIwYQlPLTd/R3DojgT0I
         sQbNLy8u5yzLbTUY+W3c1mAHx1sytYZU1JHlLRemDJsP0UA4HaIHghv3FDYaTyxbim3e
         JqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706782441; x=1707387241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/e8HqGTBoNdiXvpZKyoPnEwDs0/fPJqWhKv8bb/8xc=;
        b=bzji5430jSZz+eD8l8CDrmGqfeV7KE3AGGZfcu6cq6r40+r0wSjYNFFLKAx6Fu4wsq
         U+rQezeToJT1j4K51Vg7s1noCENFmZEqlBRt3h6Sti3Tpq20KTDqxsL1EsE0CucdHOX3
         zfGRAiiP96vGhG1PojZWZTksMurMxBpY0DYsgHjTd5Tz/DAPbc+05kXj4SXMtEJKud8K
         jmBUkun32bi0qA23UHDxwM8waoQ5DDayqEx7Hi1GMUc/AM4ebGlkyk782nC5siLJwtGY
         0cf1VEtMHB0Ywvvp3DjaeHXV+3AvG3ua7Ysh6n+bP0bcZalSD6cjypTF0njvcW1VdKML
         Yo4A==
X-Gm-Message-State: AOJu0YzQmRmDcgOL5Tj2BYzjFZacfG4uwFDOXuAE7AWhggY4UG+bIk3T
	45AbDzg0L10jnYsUSr2sCwOPpeM6sWb9eXbafFTcBMbjjRengdlidNAYJyCFl9Q=
X-Google-Smtp-Source: AGHT+IEK93z1E6or0sJbGnRUDd6jiXvN13hhMUqfzejOcW2igcwCjOxIMzIUlVCxGM4BG33e4giODw==
X-Received: by 2002:a5d:544a:0:b0:33a:f0a4:eb07 with SMTP id w10-20020a5d544a000000b0033af0a4eb07mr2964962wrv.54.1706782440709;
        Thu, 01 Feb 2024 02:14:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUalGmA1msgn1XM4nLoqZ3P83NGz4JHVfbuoAGEW/sk3lOdYY9HcgYAcSkIWYcOjMalvYafr9V5gDBZ6T/hCvFVfI8usx0A3B6VFAahSQXQ7YJ0EZmDHR6ywxaPZ9l070nrvLQACFM/7MuKHguS+a1gDXLEiPi7Tk929yYK5Jvper8As9PeZj7N/XML2N9WXHHL6iC0pA9VQb/XpxttQKR21TtqXghjqQPgo8ITf9aemTMGbMAydUGMBeFEPA4k/m8rf5+l30iI
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d6147000000b0033b0d2ba3a1sm2446353wrt.63.2024.02.01.02.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 02:14:00 -0800 (PST)
Date: Thu, 1 Feb 2024 11:13:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: William Tu <witu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
	bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
	saeedm@nvidia.com,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <Zbtu5alCZ-Exr2WU@nanopsycho>
References: <20240130170702.0d80e432@kernel.org>
 <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
 <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131151726.1ddb9bc9@kernel.org>

Thu, Feb 01, 2024 at 12:17:26AM CET, kuba@kernel.org wrote:
>On Wed, 31 Jan 2024 15:02:58 -0800 William Tu wrote:
>> > I just did a grep on METADATA_HW_PORT_MUX and assumed bnxt, ice and nfp
>> > all do buffer sharing. You're saying you mux Tx queues but not Rx
>> > queues? Or I need to actually read the code instead of grepping? :)
>> 
>> I guess bnxt, ice, nfp are doing tx buffer sharing?
>
>I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
>I'm 99.9% sure nfp does.

Wait a sec. You refer to using the lower device (like PF) to actually
send and receive trafic of representors. That means, you share the
entire queues. Or maybe better term is not "share" but "use PF queues".

The infra William is proposing is about something else. In that
scenario, each representor has a separate independent set of queues,
as well as the PF has. Currently in mlx5, all representor queues have
descriptors only used for the individual representor. So there is
a huge waste of memory for that, as often there is only very low traffic
there and probability of hitting trafic burst on many representors at
the same time is very low.

Say you have 1 queue for a rep. 1 queue has 1k descriptors. For 1k
representors you end up with:
1k x 1k = 1m descriptors

With this API, user can configure sharing of the descriptors.
So there would be a pool (or multiple pools) of descriptors and the
descriptors could be used by many queues/representors.

So in the example above, for 1k representors you have only 1k
descriptors.

The infra allows great flexibility in terms of configuring multiple
pools of different sizes and assigning queues from representors to
different pools. So you can have multiple "classes" of representors.
For example the ones you expect heavy trafic could have a separate pool,
the rest can share another pool together, etc.


>
>It'd be great if you could do the due diligence rather than guessing
>given that you're proposing uAPI extension :(
>
>> This devlink sd is for RX queues not TX queues.
>> 
>> And devlink-sd creates a pool of shared descriptors only for RX queue.
>> 
>> The TX queues/ TX path remain unchanged.
>

