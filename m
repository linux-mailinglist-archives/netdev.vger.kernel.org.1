Return-Path: <netdev+bounces-135739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB76D99F07E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C48281CA5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25971CBA0B;
	Tue, 15 Oct 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cuMJR/xh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3ED1CBA06
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004169; cv=none; b=oiW19JoHMUpHjqQ7It8BuaTkKEzyRFoSl7j1K3sFUVukc9lLqcihY6BKD92UPztUKIkHCp3pC8ZcQEDpxlg6IbiiL/QR/nZkZ1lCElt0/XQDPytiGeLHhR8LXXPguMmQ/1DqQiskeSg4+wNp5DYq1ElNiDE7QFTiDruuM25ZLRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004169; c=relaxed/simple;
	bh=Xh144mxRbUr7UtA6e0siEVhJTeqwLsGAXEYznq9rmXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX56vJFAoNUsajGRCKl4bOzXZciDp3ncBJiEtclDLHDi0FLrh0bUIvMsGfZ3GaDUJgCcLJT7n43Qht9HPnNkvbyHwqy4IDrZeNvWQTzgXWiDs0NosmXN02ut4J8PFjiTdbme/stzE68RKw1+G2RgW2aYdcJKNUonSUesQ1jLRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cuMJR/xh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so41403405e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1729004166; x=1729608966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPHd6cHR+tzDOuFMpVTXBPbSza3bMwVjTajdvN4T/B8=;
        b=cuMJR/xhz/M6qyRQVUwbp1ZvpsahlGGMaZQ1LNQ6okDP+s1Na4qCvnyiyiox0fnKIy
         gZi0JAx1tvRNEjocDjys9Y+ZcvZIqR9IYrqfNsfGD2yyMKchkyu92BC1/b3a+ORSksKp
         I01fiB9xHoY2ynh314t+6ZzlZrN7LWMjHwKElIOJ+3EdqVps7JUeqV3BFb5LhGN+KLZ9
         K7LPtdpvqNBZvB1l6AOGa0K1jWCn6OpX7EqcIESGzOhrFdzcubjrxQhmxf+FTX/SvMf9
         jvnGtY2ufPQJfyog6vCcwcCuJJiKuvSLO6rWodjUBmzG+Cwr3x5UcbWSi4N1odpj9SjB
         /Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004166; x=1729608966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPHd6cHR+tzDOuFMpVTXBPbSza3bMwVjTajdvN4T/B8=;
        b=NI28lXqvXZuMMioyZzh8DmvoOEJ3QCBZsz3w3jAeFVacgpH5Pqs0DnKM/Pqh8B6Afl
         STqQhEwkenZJ/m3Oyv/SUOoKe1ERMBnMzZVvfJAQB0eyMiQHrj+UED4Vs+R43iZIyO0i
         OUXiydA4xlp+2YQlAd3fx/Q7ycgRCzamwW66tXyWMv4NJIIALgzcETmdKJawGY9HsWkn
         DVYfDQk2inkN5KQUYyheSs/g1UwM74vF+leve4Rd/Paj6ypeiC/m2sNtw0YHyU25Ww7S
         yt3hTfu03cjOzJq0NgD6LCeIYepWX0Cdy182LbvaVb1gA93xk8/BQeE5lYmK47IkqTI1
         Ks6g==
X-Forwarded-Encrypted: i=1; AJvYcCX0Dq3P1h3khIcQOtKsUMhpvds51TjMEDWd/SdJwdrUNgO7ivn07zFcCBODVrASegcGRNZI7pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+LKflec/SNdNLL1zHhRcJgucd0jWVQKHtioovr5sPfIRaqB7l
	HoPZIq0KyV8XZSWeaNGot0jkOVcr/kxwBpyLmkFvHiNBgCHOyiBb9A39UVh9iV4=
X-Google-Smtp-Source: AGHT+IHbrd4jQKT72qhauhTSC7wqb0bkeu0HGE3XigVdRwbUYwE6iXmnC5Ql8/zQWcz/h/LgyZpTTw==
X-Received: by 2002:a05:600c:45c7:b0:42c:a802:a8cd with SMTP id 5b1f17b1804b1-4314a2b59f7mr7233465e9.11.1729004166313;
        Tue, 15 Oct 2024 07:56:06 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b1e42sm20223125e9.35.2024.10.15.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:56:05 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:56:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	donald.hunter@gmail.com, arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <Zw6Cg1giDaFwVCio@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
 <20241015072638.764fb0da@kernel.org>
 <2ec44c11-8387-4c38-97f4-a1fbcb5e1a4e@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec44c11-8387-4c38-97f4-a1fbcb5e1a4e@linux.dev>

Tue, Oct 15, 2024 at 04:50:41PM CEST, vadim.fedorenko@linux.dev wrote:
>On 15/10/2024 15:26, Jakub Kicinski wrote:
>> On Mon, 14 Oct 2024 10:11:32 +0200 Jiri Pirko wrote:
>> > +    type: enum
>> > +    name: clock-quality-level
>> > +    doc: |
>> > +      level of quality of a clock device. This mainly applies when
>> > +      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
>> > +      The current list is defined according to the table 11-7 contained
>> > +      in ITU-T G.8264/Y.1364 document. One may extend this list freely
>> > +      by other ITU-T defined clock qualities, or different ones defined
>> > +      by another standardization body (for those, please use
>> > +      different prefix).
>> 
>> uAPI extensibility aside - doesn't this belong to clock info?
>> I'm slightly worried we're stuffing this attr into DPLL because
>> we have netlink for DPLL but no good way to extend clock info.
>
>There is a work going on by Maciek Machnikowski about extending clock
>info. But the progress is kinda slow..

Do you have some info about this? A list of attrs at least would help.

>
>> > +    entries:
>> > +      -
>> > +        name: itu-opt1-prc
>> > +        value: 1
>> > +      -
>> > +        name: itu-opt1-ssu-a
>> > +      -
>> > +        name: itu-opt1-ssu-b
>> > +      -
>> > +        name: itu-opt1-eec1
>> > +      -
>> > +        name: itu-opt1-prtc
>> > +      -
>> > +        name: itu-opt1-eprtc
>> > +      -
>> > +        name: itu-opt1-eeec
>> > +      -
>> > +        name: itu-opt1-eprc
>> > +    render-max: true
>> 
>> Why render max? Just to align with other unnecessary max defines in
>> the file?
>

