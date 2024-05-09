Return-Path: <netdev+bounces-94851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F788C0DCE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E710F1C21EC3
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB614AD14;
	Thu,  9 May 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPMfW6Ts"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB26101E3
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248366; cv=none; b=Q5G92VqW8hmlNozJQi5SzYWhUWZrYQWdVYtqFrC7gfTltgJNZdxBouIHMHHjI2nDvj7oySojc71zSIKhre7BZ/pNaMP9ozVLUzAUOAQwa9ptSNWOw5GRxK7FcLcpMjjy3XXJkzdyKNQVKRQehC65N870LL/2PciIvMOyMMJppXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248366; c=relaxed/simple;
	bh=DKnNxWZ8QTqsi54wCJjIap/qZVVF73g4UU462mtxz60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TD5VlXxq9dXPhFfbHy1tAHp4/zpwfRW0lxeOtTp2p6PQrHsclItmKPJ45MBu3mbSXH45NFBSIWsUL1dYErZiIMs6AugQBa16tdGHe78JEJcORi+6bnpwl1UFYTg4m2E0jNfAHIHmwKgP6Q0SwHKFX7bcuIlUFseZKjObNaehSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPMfW6Ts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715248363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DKnNxWZ8QTqsi54wCJjIap/qZVVF73g4UU462mtxz60=;
	b=OPMfW6Tsq+Xi0pDKATcGOWdrgTtt2UaHjezMEuV5APDIrvKlkopYQWPBKcq3xXE4irmDl+
	G/+MVlkRhXRl1sbNF33UqY4IzgNaXaq/EmtAUOzW08N/DQ9S/taLM4VIvK9H0oxu1LK5mZ
	rTlOaANk4s3n7pXQcGiTD6GBGD4sbf4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-auin2wvHNtqZghZ47WfJwA-1; Thu, 09 May 2024 05:52:42 -0400
X-MC-Unique: auin2wvHNtqZghZ47WfJwA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34d7ce41d7bso101507f8f.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 02:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715248361; x=1715853161;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKnNxWZ8QTqsi54wCJjIap/qZVVF73g4UU462mtxz60=;
        b=AKNh0ZlI3WRhAcACPhni2qipJ4bG3cq0s8AXaKH0V5Sf6X+8d94OEU8mDx5Ce/fCO3
         ibYRYar83nEbjEhOvAhXyOo86on8Buxd1I4Jbd/cgJPwOSAuhAroCWuxAUzkNnafWI2C
         WfTNBMReUdP/ocli2jgQZx5coK04mytheIIA7Yd2yeS2HM/xX2KjIBFASwb35St4DZlZ
         J20Vr5nWdmlRgFFSpfMj0ntbCmaEUhpUjKGtP8G2rystTYqptJgNIzSAQk/5g6jO5Phe
         2zDgOpnwZ/YO/LoQ3G5V9fQ5BceWIpAhHj59cAOuCv+iu1M4nwWU/GmRd7Fdk3D19SGV
         z8pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwZ1igDgwSkXa5IIxHnv86/WQ5Nq4BYq9bkIhxYVEuG1B4Tpn2cJHDGObBP/58UtBiIpaOIQIiFs9yYJKX+N+zcpa8ZVbq
X-Gm-Message-State: AOJu0YwDBvkZIUdIU0mXDk/fgyScuGoQCjGhdSiKPSJKHez8TB9OVhOZ
	7LQBw1FqLtrPgGug7y3xIU1GTSy5VbPmRSKObr1Ra/d/1i13mxJH+SKpD3A42lyjRLjE/iAuNSk
	Ft1uIjMHy/VBaCtzihAHDO95SIalZotWC7L+gbw6uuuvehYJPcODmdQ==
X-Received: by 2002:a7b:cc16:0:b0:41f:9c43:574f with SMTP id 5b1f17b1804b1-41f9c4359bdmr25243705e9.3.1715248361057;
        Thu, 09 May 2024 02:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBw+5WesTm1k6TyMkCgqU7yvWz3P+RLg8DjBfWjRRtkO3wcYF4sF4B6adEigXsQBYrPMYuAg==
X-Received: by 2002:a7b:cc16:0:b0:41f:9c43:574f with SMTP id 5b1f17b1804b1-41f9c4359bdmr25243545e9.3.1715248360647;
        Thu, 09 May 2024 02:52:40 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10:ff61:41fd:2ae4:da3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f9ffe26acsm30355035e9.1.2024.05.09.02.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:52:40 -0700 (PDT)
Message-ID: <417acf11e2757cc0a4a6480f75e4320c7bbde839.camel@redhat.com>
Subject: Re: [PATCH v2 net 1/2] net: dsa: mv88e6xxx: add phylink_get_caps
 for the mv88e6320/21 family
From: Paolo Abeni <pabeni@redhat.com>
To: Steffen =?ISO-8859-1?Q?B=E4tz?= <steffen@innosonix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Fabio Estevam <festevam@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 09 May 2024 11:52:38 +0200
In-Reply-To: <20240508072944.54880-2-steffen@innosonix.de>
References: <20240508072944.54880-1-steffen@innosonix.de>
	 <20240508072944.54880-2-steffen@innosonix.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-08 at 09:29 +0200, Steffen B=C3=A4tz wrote:
> As of commit de5c9bf40c45 ("net: phylink: require supported_interfaces to
> be filled")
> Marvell 88e6320/21 switches fail to be probed:
>=20
> ...
> mv88e6085 30be0000.ethernet-1:00: phylink: error: empty supported_interfa=
ces
> error creating PHYLINK: -22
> ...
>=20
> The problem stems from the use of mv88e6185_phylink_get_caps() to get
> the device capabilities.=20
> Since there are serdes only ports 0/1 included, create a new dedicated=
=20
> phylink_get_caps for the 6320 and 6321 to properly support their=20
> set of capabilities.
>=20
> Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be fi=
lled")
>=20
> Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>=20
> Changes since v1:
> - Removed unused variables.
> - Collected Reviewed-by tags from Andrew and Fabio

The changelog should come after a '---' separator, so it will not be
included into the commit message, and you must avoid the empty line
after the fixes tag.

I made the above changes while applying the patch, but this is really
an exception, please take care for the next submissions.

Cheers,

Paolo


