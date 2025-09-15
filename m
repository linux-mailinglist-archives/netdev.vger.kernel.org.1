Return-Path: <netdev+bounces-222960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42DBB57434
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC05441B81
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22E92ED174;
	Mon, 15 Sep 2025 09:13:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C51E7C2E
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927584; cv=none; b=iXRp4etBeZhyIbVENY+z4NOW5X8Cmo8we+4ZVTSwxUCbZ0gWURJuZTxYLXNv/JkvajWCmN5PqLGJFWYN7t89XLJcUqLK3aCQ48UZETwurBw26bUXK92dmR0gNK0FGrp5d131gQUTW22xTP2yqaHeBfIb3NC6ABzJRD+uuKKYE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927584; c=relaxed/simple;
	bh=7+kB8ZMerG7yaoGrdsJ+/bImc0MjKYSjj9HksU+tMr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAhib8c0vmBQ2+Yo6pWN+ntLAMnhfbSh3llFSHJvlrE+mj8RjOPPA9lAmvDHrIsT91XxJUzbLfmt2ordLVTXialvDXW912B9mrNG51bBF0G4hIcfTU/LExPjfHMgWs82khiEvQ3yDXCxu19rL6TSRDiavX5AgV6Nu3hVISHYMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so328513a12.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 02:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757927581; x=1758532381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtNRcJRwwCKEIJqf9/whpSBRpMqLegKM6RuT3nM+mBg=;
        b=Bf5ZEPzCvqj4Cfkq0+uLdjCEUjJQWh26skYGWHb7ga0ZpVv8SPYi3WZWgqM9uuuH3A
         5cloNDANIJaYv7QWsN++TUqizcx9E7H7OMc2LuAu6BofDrXCRorjbl1BMmpM+wBWTJLG
         uYlu3RgW/3J0SLHpbWK/AM7wQh/lLda7URLrsHx3D6kBzOE7NP2qCsD7/p/r5+Nr+/DD
         ZAYG728mQzKL8aGkDHG5EYdRZLhioivv63+KEG3a/M7ITsvDFc+aFLwjm+3zi1TdYL1z
         sBdXex3SXtMCUXeoVDXCuhsZtd15xVv10IcnCoud/W+VqdC8ISi7lM7xg1+L8ZfUBst0
         LJyg==
X-Forwarded-Encrypted: i=1; AJvYcCUQLNEnQ9zdKfkQzX5ZF89+W/trzJtR8C6chkJl/cgymQJU4vRCZsvRooi955s9PGv1iUPR8dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxasI6aktW0hDtWpXeWe9oRE6Uknmu6x4jgYOhQka5H+cfoSelZ
	br5Ts5cYww4N1YH7iW9pfnjmG0VcKqk4Wh5/ksZdO2CufoivZkMfmljE
X-Gm-Gg: ASbGncvha8umlUWRg7TtZT9qTIMhDHRje87voCGC3fJyHUl0EBEDkBZGACYGkmjgdmy
	moU9b+5QkZ+pTPRGoWsUQOWKRER4Mm9rZbFkLBBHT5faUfbWdVNpGEQ9LgO0ed3COkYs62Qy/HP
	n2vtAb5OCEK6mGeKM3FDe96H8QCM3ZIxOv/F3Mw7kT2+cJVBqkW7ua61b9egs2L5g/4+N3KJifm
	K7Q26fYvVuPj4jcsi80diNw0vXfN5DjIaokbBeepvWngW/UvNeMLokb8Q5kTjP1Di2RuiZTFriK
	NdufBwMTttAt7pniTNOF29QvvLvoBOkDMxI+4E+ZVrTNi23BStXrBW4ZEK1Jd/LgcRtaumvGtB1
	AGdp731U5GOX5BdpDZPiHkr6J
X-Google-Smtp-Source: AGHT+IEAqk1Bgc7JcF+1aQKWXD0BySjNrACtXO/rAEWZU4UuzJsWjT8CX+gGJiPIKhaccM3UW22mlQ==
X-Received: by 2002:a05:6402:2742:b0:61e:c750:1ef2 with SMTP id 4fb4d7f45d1cf-62ed82c6d29mr11320958a12.36.1757927581094;
        Mon, 15 Sep 2025 02:13:01 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f0dae0140sm4601341a12.48.2025.09.15.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:13:00 -0700 (PDT)
Date: Mon, 15 Sep 2025 02:12:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/7] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Message-ID: <zskbmdjunfamn3x3kmxcjeamnckfh4icb7emwkkwhqwstlzt2e@nqjcg5h6hgsv>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <20250912-gxrings-v2-4-3c7a60bbeebf@debian.org>
 <20250914125949.17ea0ade@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914125949.17ea0ade@kernel.org>

On Sun, Sep 14, 2025 at 12:59:49PM -0700, Jakub Kicinski wrote:
> On Fri, 12 Sep 2025 08:59:13 -0700 Breno Leitao wrote:
> > @@ -1225,9 +1242,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = ops->get_rxnfc(dev, &info, NULL);
> > -	if (ret < 0)
> > -		return ret;
> > +	info.data = ethtool_get_rx_ring_count(dev);
> 
> Is there a reason we're no longer checking for negative errno here?
> It's possible that none of the drivers actually return an error, but
> we should still check. For consistency with the other patches / paths
> if nothing else.

Agree, we need to check the result of ethtool_get_rx_ring_count, and
return it if negative. I will update the patchset.

