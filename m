Return-Path: <netdev+bounces-73170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4EE85B3E3
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4A72840BF
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6675A4CB;
	Tue, 20 Feb 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iV4P2u5n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D175B674
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413859; cv=none; b=gZqTMhXnAue0CceVGbubL7Z21tvxbqi6Rb/KOH0vya7VbxAk2mbkdW+aQA+7JH7BJqbjt/DbdMZmkb9GJ0tx5xBJbi7pnMpc3D/mCHDzmLyWbDjsvV0IVd1/sr2rlcF66zDPuH59G7apW/7qLADOEe6cD3PfBBKB9JnrJLl1g4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413859; c=relaxed/simple;
	bh=7DqyzSMdbCs5p2alD3N3AzlsCQXfYjqSbhC5sVY8TUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZqjDLFGRHAlDD3/ILRLulvEC6RClU3zBLLouCQHZG6UbvCV2pASh9p1/0sjRmPYy4atPAQF6K6JO9FYoeFYSUdv/j3I84Xu2K6RG88iPl1wuFJKpc9D4ZtGQqgUin+PLRGmI1vlgGyNJv3VO3ib1Kh9Edrzc+7/liE/QssnChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iV4P2u5n; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3392b045e0aso3197057f8f.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 23:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708413855; x=1709018655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zjrHuQblrwOTIdPLNps+P25zUWumEJHV4pnVL74VHg=;
        b=iV4P2u5n2dpXOE95fdeRQj8GzCeWvLXvU8wIK5DZHsZR+T5WghEU0I6LOyJkXvu7zX
         JJZQtyga1vzjIQ3d5uX7LXD6j7en8ww1wrgJ+UGaDBGZMIMhLiiwp6K357X/+bKoZ56Q
         x+nrVI9znclHombcx4axha8IAPCQ57Vo88CabQJ7UpxK4SchEv9oEdjxX4ZoOTZVWOjX
         LrovUq+KjfsklNdBvsXwjpuzYh38FoL1B8qDt9YXyDj66Ivhklge7j8tVJRlxf5NnZJt
         9/FFpbU++6U8iw5/izYj1qaDyzMCGf+yUziyufS6F4aisWtmVB2BAQOQlRefMpBOBxMB
         bTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708413855; x=1709018655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zjrHuQblrwOTIdPLNps+P25zUWumEJHV4pnVL74VHg=;
        b=SCtKVSFpHxcoRNvTCs5MUDA5two+ndnhEeLmkKKjfAY8SJx2KumoYoRJGd1qgkdoxd
         1GJrwIRMio+Om8EQ++d0QlUwZ8YzXzc2m1I5fYr216Q4RTuwV78uFwrI5SINkWTuYh+Q
         6OVWJMbPMxcTeGT8zHZfQ0F/WL6ZqKuxq+onufahaETt8W+QWooN8u1lgXB6QSoeQr9E
         +S8fltvaLIzBxyz/glAjQLpNiRS/OSz76Gis4IP2u1rGKrz1mYlaX4YJK8I80oyo3msG
         l2t73kgUTpqb7NvxjIWBCZYcfqFfLArov0rPgUnjUmTKvHTwx6g5SMP8OSxNGhAFUAvZ
         Hq1Q==
X-Gm-Message-State: AOJu0YwY4SbBYdFtfwMk65P5xyA2PsEuLgLCIxysPfYSdRE0N/l4u1q4
	GmbmMB6jEZQ1VKQ8i206kvLyDYYR0ZfyyrRiNvt1Z83Bmn1zhx04AFUhGVjVCSg=
X-Google-Smtp-Source: AGHT+IGxaC4HbRZT/t6vzb5n2I5SFlJXoZSuwgC/rIgDUklfAABIE7gO0xUCbEX/AAJ1GY/vNSktBQ==
X-Received: by 2002:adf:fd48:0:b0:33d:1f9f:afa with SMTP id h8-20020adffd48000000b0033d1f9f0afamr7804262wrs.30.1708413855024;
        Mon, 19 Feb 2024 23:24:15 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ck4-20020a5d5e84000000b0033d3f0eee9dsm7133758wrb.27.2024.02.19.23.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 23:24:14 -0800 (PST)
Date: Tue, 20 Feb 2024 08:24:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com, donald.hunter@gmail.com,
	sdf@google.com, lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 01/13] tools: ynl: allow user to specify flag
 attr with bool values
Message-ID: <ZdRTm8cX5uDp16uv@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
 <20240219172525.71406-2-jiri@resnulli.us>
 <20240219124222.37cd47d0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219124222.37cd47d0@kernel.org>

Mon, Feb 19, 2024 at 09:42:22PM CET, kuba@kernel.org wrote:
>On Mon, 19 Feb 2024 18:25:17 +0100 Jiri Pirko wrote:
>>          elif attr["type"] == 'flag':
>> +            if value == False:
>> +                return b''
>
>how about "if value:" ? It could also be null / None or some other
>"false" object.

Sure, why not.

