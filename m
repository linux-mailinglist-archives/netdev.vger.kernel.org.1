Return-Path: <netdev+bounces-209383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86687B0F6B6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2DF188361A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14152E8898;
	Wed, 23 Jul 2025 15:06:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B11DE3C8;
	Wed, 23 Jul 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283211; cv=none; b=mM9iQBUGg18w9mPlYOQ5CVBdrOSp6M9Yh4xInq5Om6JKpUCvqi9HXpa9iYzsbOgAlFLNY/OXly3Nu7cSW5IckOFuwCQZkvhJQbCn3tqwZMxYSNWMV8ymWhkcS0t5RLZ65TBO14QxXgeVEqFRxIu/7H+7oOSKSB3y1xaHa/e673s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283211; c=relaxed/simple;
	bh=dPsrrT5gnGdkbnBW8zvtvkYTqGG3yz/+xD7EMsf7CZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUMOIfRpJBHh3SoFfjUPq2SMfjw9jFMQFaNnCUT9kVf9yt0M1wOL5d4aykx7hDkW9W+pObw7N94yu0E2NUavW02xwFGtebSDd+3Ts6oXT5GWbYMk12wiLpWlKITIgAn6Y8K2pkfxo8c7I/Bv7lP6VwYeJzfaYLBzTGFugiUI2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0e0271d82so1271432266b.3;
        Wed, 23 Jul 2025 08:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283208; x=1753888008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjUMBpHsAQr3P3nCaDXJBng7dmRo/imn0v6lMadWIJ8=;
        b=v4WsoY3JRek9fQhBpgKG3HtHgl/ZcN0qh/QYQ9NPphncj36JL94CGdYaTDZ3mmf4hX
         9s/cK9ZkfRC/UVwfP+u014JjChRBq5H2gMDiiz+q2YLTTXgdQUacMg+JC18p6yorrVqa
         dEwhYLllc8SghKGn9dWCaDUieuKrYPArf5BcyyFyf7X6G9ZB1o3avpl2adTWwRUxi0lE
         rN/qTXwXDFlqQI7YHVOCBX2c4rfXP3VEgTO6V/XM50KEDKHPbA7p5wkR3WbBer6ghc5U
         WBTlg5Rtg+3UMHboPmBMVszK+Ro0ppRtHm1Wgpugfe5xTnuZXT68oW7hQM+qGRAh+/UE
         qHkw==
X-Forwarded-Encrypted: i=1; AJvYcCV/8TK5fd8GtTOfrYfcu0e0rUi9ar7DUNI5zeYsthCRf3unzzw4El+RwTADU3CRLVj3+UkNmkRDDkRe8l8=@vger.kernel.org, AJvYcCWG4ttrvyqfBzpKZNeqlp9iu2sHU/0cymeaTT2cQN8xCjjw1vjz1bnLAdnggb3i3U6BKd9tleTO@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUqGj93SczOR0gYpUe/OJ4ulyE6T9feBRNbXU1qXw0kAiaDLZ
	V98LmM69aveOajTy7zyP/9N3+xF1smEnrhbcvbcuSUnWZz+INSrig3F1
X-Gm-Gg: ASbGncsjhxlkoeqACIsRFABxmhx1rUsBDsC9A4LUuevrxYmCXbdYbjmDgmea8mmcXMJ
	8Uk3MOh63oQ7ySUlM4F7D5EonLR2lJK6Hbs7pikVXvofCpKd4TJ5k8gnDRUZ/edcdzUNWxb2158
	qkndyUepTXkD91thh9SL8cQXBmZz78vxips4GUNiXJCrrREPWwfageEt5bdjiDEGWSZXwu/Jsu2
	NpLzy/V2ZfjRHXPE+SLgtmencRXVqabj+Cb/ZMVQEQ3OsFuObWgrWTJF5zrO8rgTqBQtKA5SBP8
	eoFsk3QRJ9ZGhIvpq3O4BNj0ZOjWb+WchAdieYzPFwv/NBnuaJYFVb2LSMU8nJQWnq9MTasIbU+
	esj27Rds7+Q==
X-Google-Smtp-Source: AGHT+IEg3/R8kr5paUP6cFtSCEYF+alez3ezKbbkxAZQOVtZ5YigmhHzkFW7tOWrnqehfypQgVnxgg==
X-Received: by 2002:a17:907:a893:b0:ae0:c0b3:5656 with SMTP id a640c23a62f3a-af2f6c0cb8dmr339397766b.22.1753283208082;
        Wed, 23 Jul 2025 08:06:48 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca312d9sm1060974566b.94.2025.07.23.08.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:06:47 -0700 (PDT)
Date: Wed, 23 Jul 2025 08:06:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/5] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Message-ID: <rsvfhrzqn4zwb2g5zrr6t3ige6lic73xtamzhmcr5flkwaor4a@x4s3sy6uqrcx>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
 <20250721-netconsole_ref-v2-4-b42f1833565a@debian.org>
 <20250723145400.GB1036606@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723145400.GB1036606@horms.kernel.org>

Hello Simon

On Wed, Jul 23, 2025 at 03:54:00PM +0100, Simon Horman wrote:
> > @@ -759,23 +760,10 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
> >  		goto out_unlock;
> >  	}
> >  
> > -	if (strnchr(buf, count, ':')) {
> > -		const char *end;
> > -
> > -		if (in6_pton(buf, count, nt->np.local_ip.in6.s6_addr, -1, &end) > 0) {
> > -			if (*end && *end != '\n') {
> > -				pr_err("invalid IPv6 address at: <%c>\n", *end);
> > -				goto out_unlock;
> > -			}
> > -			nt->np.ipv6 = true;
> > -		} else
> > -			goto out_unlock;
> > -	} else {
> > -		if (!nt->np.ipv6)
> > -			nt->np.local_ip.ip = in_aton(buf);
> > -		else
> > -			goto out_unlock;
> > -	}
> > +	ipv6 = netpoll_parse_ip_addr(buf, &nt->np.local_ip);
> > +	if (ipv6 == -1)
> > +		goto out_unlock;
> > +	nt->np.ipv6 = ipv6;
> 
> I don't think this needs to block progress.
> And if you disagree that is fine too.
> But I would have expressed this as:
> 
> 	nt->np.ipv6 = !!ipv6;
> 
> Because nt->np.ipv6 is a bool and ipv6 is an int.
> 
> Likewise for patch 5/5.

Agree with the suggestion. I will update the patchset with your
suggestion.

Thank you very much for your review, again!
--breno

