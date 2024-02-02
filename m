Return-Path: <netdev+bounces-68427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CC7846DDB
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA70294ADA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441E35FDD8;
	Fri,  2 Feb 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PS/zWvzC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD73171BA
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869539; cv=none; b=KbSGQhUcVfEOoYOlOWx0XOEPvavP3oEb8DHkl/DLqOYBigWqVs4rSjYMVktudY80KgQe7OA1G6tfaWL8t07NYb+r8RLUQ6TySLNKRRfSA4eZ52DIN3G8dsfJl6GRCMRpsn3kWiCVvukRZYszS4MTsuho0MX5v3qiCiEPtAgkUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869539; c=relaxed/simple;
	bh=2+5uXLOW0/UEgPIT4XpFOUVMqmvEumJBi5jyY8MIJdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irm/xLHYYcra/auCQiL3eFMcPaZs77Vf5LH+SwyIuIE99Qn7I8zEcRX2IfcWnfmKNnprk4hPZp8/N1zICAKYzshhLNjZXLucbLYBCvSqrPNnco1Tgs5JX5l9hlju7QevYiTR6Z+as9s7nrdoUMCGopIeCwPe6eLbMMxS1JM5OFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PS/zWvzC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so2644351a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 02:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706869534; x=1707474334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+5uXLOW0/UEgPIT4XpFOUVMqmvEumJBi5jyY8MIJdQ=;
        b=PS/zWvzCOqw1SZDrzhU9UyxKvSsi7g5dKNdvQUVJTRkq0XvHof58pqqKS7uzuRA7qf
         HobBpJL8TT0bpsDmnHgknDtjRh8i+hbyO1tNDVBKhg2l07wmEktFK5/oJqbG5l3mi0fK
         nneJP0aTBj7CXh/jSMZuGsDNrZy6IPPU3BD/Mv3/jEM8SkhNmE6uAr/PsLjwpc0yy/gy
         KuyGnkj8E5Rwpoig1JxHV/HUG7IGbqgvf3NfTHKjX0NVvzzHlMrqbOhbKQwSIndW4UZt
         VztJoqz3vay+9eDhi4aMGH21h1RlljMKl2pwwUabl5sohBKzEkhZbRn7mLQ8BasmouHD
         bp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869534; x=1707474334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+5uXLOW0/UEgPIT4XpFOUVMqmvEumJBi5jyY8MIJdQ=;
        b=DMOc5jB9UrvdMhge0FJOgrO0o3POYmdU8wai5NEKPlQcFFMB213qB3l7UDAQfVfVnO
         yNnBvMSoszLFVVNworHidfkzww3899tZ7QvvcB//QAD+zu0rUWApRI2YwH6pZ/HfUo9D
         5+5DXSmUzNzdFQ+PCwL4WMA9Ee7i3cvh6VkpvkyLsPTdanfbarUG56vw4ZfTA+A7YmxK
         TKhVGDCsRXefgFeDGBp6R6o2vQLoAEosjfKphd3YqFo8wWkxOChEzF78/EGfvmD3FgSN
         6stbGv50r3wESvv6y322KC6fXD9NcK3BKm48kXv/ScPgtFPeNhW6Kxo2CP7vLyKgtBuf
         B1QA==
X-Gm-Message-State: AOJu0YzUE3WDknThaXEr+kxIXD9ZCtyd2jQxmPcdHWQfNcB4T3yMppy/
	zkGTwiYuvRmDtLGg84Iq9VGr3R1MrQ/rxkBAfYg/J5XWka6WAP68Wya+AKvAnns=
X-Google-Smtp-Source: AGHT+IG0ioGGqLVo7vsPf73X2N7j+l7zLkBS2OQqoIQdbmvuottwcdzgbGiKZgzaWXDDtJAdnQEmqQ==
X-Received: by 2002:aa7:d314:0:b0:55f:e9e0:1cc6 with SMTP id p20-20020aa7d314000000b0055fe9e01cc6mr1041778edq.16.1706869534390;
        Fri, 02 Feb 2024 02:25:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUjMnxUapRLUChndXG9Fn+AnXf4z3MZ/56Fnu969Qv1HBOmWZpuuzJgXihx407h3qX8+TtzUV0UJ654cB43Rz/RXxYfcBnrriJvvTY+O5hCu3UV7D7mTl2X1WSfE3vjF3ruyQVGD83JEN90eZXwzTRqsnT9Unx+Rl4uHEXwEmvS9yQc7EzfibdIYpc9jD7ZC9uNemUS/34oYvvw/xyBd8OBSl8FQsYnr86U
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c387000000b0055fbc52457fsm677601edq.30.2024.02.02.02.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:25:33 -0800 (PST)
Date: Fri, 2 Feb 2024 11:25:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com, sdf@google.com
Subject: Re: [PATCH net-next 3/3] tools: ynl: auto-gen for all genetlink
 families
Message-ID: <ZbzDGyocvZQvOZZV@nanopsycho>
References: <20240202004926.447803-1-kuba@kernel.org>
 <20240202004926.447803-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202004926.447803-4-kuba@kernel.org>

Fri, Feb 02, 2024 at 01:49:26AM CET, kuba@kernel.org wrote:
>Instead of listing the genetlink families that we want to codegen
>for, always codegen for everyone. We can add an opt-out later but
>it seems like most families are not causing any issues, and yet
>folks forget to add them to the Makefile.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

