Return-Path: <netdev+bounces-68905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CF4848CB3
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 11:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C807282A51
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9821B5A4;
	Sun,  4 Feb 2024 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDKmt3rY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03EE1B59E
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707041870; cv=none; b=sD29W1LNRoCegsdMz1F+D/bhfF+aKRw02DJ3estA/JjV9R7hi3V/DXKDyOL7p/S3bq7eJ4qDmEbDRlkfaJ/OTxcmOOzCpUS/pxH2le1Xf2hxtjcZue/ZUzbV89LM234RgGbGBnVE78puLi0ySV09dSjLAZQUABUUxPzzyK9Qinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707041870; c=relaxed/simple;
	bh=TmM8S62LNfDHGUsiPWA8kS47dp5TyloOBY9Nvd9vSGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoffINdlkqGpqB6p6R5WstZYQdBJDkkq/OwK6uVbCskLEu+ZIzb6louh+Mz/ypXvxSphxCx20O2Z43cqpTyIjK4UwWG1fyno1r+mLNgsWX7o5+uyk5OHBPMdgQ2beJ1+XuuMuF3GgmFfEGvlku81/+aAFb82DXh75k+T8B2Xly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDKmt3rY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2892278a12.2
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707041868; x=1707646668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOxXNbjmzi48UiiBeKQKOOR7ShdxOqwul7abe7KEYU4=;
        b=hDKmt3rYcb7dentfLiJojC/Zkd8P2QPHCPJUT4TXK7Jo0l0+dtFv/5KVicX1bI5lOX
         6Npd+zbcFYVz+hB1GVCy05n2t9ZBvsSh1xNWLF7QcW52GWBgQllNWGKBRyZW0UJwg0qN
         YsBR4WpbqSg6JLUwN9/iX8hbdbGKvaCs0olgOBxubhDkzAVBAFMnNZCEePaUvZb6SP9p
         WzAvWuj+IDTgJ/nSdPaiDglpny0Ms+JA/YuUTSxJUh8XbP11ZNmS85yK/tcIDtBKDy45
         +KcT7hgy/K6a8grHgxF4R13TC5uL3wxJRpAT5h4MYnApfBQc3TtNQgCXFrcL2gGb2dGD
         GQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707041868; x=1707646668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOxXNbjmzi48UiiBeKQKOOR7ShdxOqwul7abe7KEYU4=;
        b=ikp68evG1wJr+dZ0nW82ZmhY8sIns4hUSp6Ezb4u5+lO9cUsVDVM23uWI3wbhLHfpD
         wPc+VaFSKRtW3yAQKIQo7Kt94phOszjN1fPIJ/WsLc5oSKH9+6oIP82/jxtrSQg3S37m
         ctf+dGahavULiv4M/yLHEZ/PlYLMLzUBepC3A64Nt1432RvN1Qe8m6PXeiCt6T7cSsfk
         4Fe32lfveIbmlgudsSgjo8kdYeMIcqOD5ADUki2+hEL9vYt3QHbEUZhvdJ49i88Gdmbf
         3IZzGxciXHvNqasQxD5tLbTWlVKsnNDS5ZBOu82dWoT6ZBcPgLfFK4qaFx6/N79PZCyn
         c5Jw==
X-Gm-Message-State: AOJu0YyedRXSpd90IdZTUHjlCPtk1NT8nb0fVl0NqlRgXlS1uuRkRRvK
	7fbBwGo2xrM0fxYlQa//2Fh7B6MwLvQGTGZ2MAnksxxt3vzDBEN2
X-Google-Smtp-Source: AGHT+IG3LisjNQKPARMgeU+n5OXx1Lkcy8yjpKnVn9TE/GL6opQSNRw7pkL8rKeVUcVnrP+NT1EALg==
X-Received: by 2002:a05:6a20:2002:b0:19e:2d04:d775 with SMTP id w2-20020a056a20200200b0019e2d04d775mr10486390pzw.50.1707041867878;
        Sun, 04 Feb 2024 02:17:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlpOSRqRpNu8qDKEM64gFHTrHYqbrN+XY7W/VGRd+oijpwWUqMLF1O4c3cl4fAATi+leb9g9wSLQqHsqP2G6TnKeAfbuqgdMoZWIJ9h00bj7vikAkMD83RQxPkn68FlGYd0mdN7soa9Bg9Iei21cmhEXitL5wywJLowb7hb4szTEzC/MdJ2smXBt2lXsEUESncgJ0PjrI5+feJ7yWnUheF5kbN+jKg4UkOH7nJWRxOXzGoxdFkvP090H+OMZT2VRnbTSfJNZNi1CDO1hIRqD5XX570OjszRloO2Wv22IYxO7mLPGoum7AD0NuaBZ1e+C72/+zPnO8=
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y9-20020a62ce09000000b006dd6c439996sm1865634pfg.161.2024.02.04.02.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 02:17:47 -0800 (PST)
Date: Sun, 4 Feb 2024 18:17:42 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org,
	martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kuifeng@meta.com
Subject: Re: [PATCH net-next v3 4/5] net/ipv6: set expires in
 modify_prefix_route() if RTF_EXPIRES is set.
Message-ID: <Zb9kRrG_7LRl1i2W@Laptop-X1>
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-5-thinker.li@gmail.com>
 <ZbzdBRd4teS_4Eey@Laptop-X1>
 <536038f7-cc33-46c7-a3e9-2c9f27bc9c81@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536038f7-cc33-46c7-a3e9-2c9f27bc9c81@gmail.com>

On Fri, Feb 02, 2024 at 09:57:46AM -0800, Kui-Feng Lee wrote:
> > Hi Kui-Feng,
> > 
> > I may missed something. But I still could not get why we shouldn't use
> > expires for checking? If expires == 0, but RTF_EXPIRES is on,
> > shouldn't we call fib6_clean_expires()?
> 
> 
> The case that expires == 0 and RTF_EXPIES is on never happens since
> inet6_addr_modify() rejects valid_lft == 0 at the beginning. This
> patch doesn't make difference logically, but make inet6_addr_modify()
> and modify_prefix_route() consistent.
> 
> Does that make sense to you?

Thanks, this does make sense to me. If there will be a new version. It would
be good to add the following sentence in the description.

"""
This patch doesn't make difference logically, but make inet6_addr_modify()
and modify_prefix_route() consistent.
"""

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Regards
Hangbin

