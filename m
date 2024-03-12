Return-Path: <netdev+bounces-79431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DA8792E5
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8AB1F235D1
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4E79DB3;
	Tue, 12 Mar 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAPexdey"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF979B98
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242557; cv=none; b=cWusKaDZACDPQ3B3RrYUe1Qr85ySn9J3/CcPL1DB2aKFo+ngWf7KVwsXwo56wXwYTECAGiN8A44LY2L6MkztnRo9X9lMOm5bnZoNfj5pv1Hl2Gsiyc2iMs+rOVMZ/odzE8cAZgyjtPM8YPGG+t+KaVUKftM2xqObFde+X9dPLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242557; c=relaxed/simple;
	bh=NLCXkr5Zuk6kdLKNOJuPB60TG7iCZH6aOKYJBL0V7ik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vD8V733ijcTXrGfGRFSjtM65ag+bdikCrRL0Zggbdv4j3oXRsoeDyKJSKLev/fqcCpZFRSn77FMrr/xkzy6uZV26gWxxfiTqgBqqwc3IKL9gI/H4CqaymjTyxXmsyp46vmKGNw6/dsOeZsPjJ02IXvFmVcqQEPKQ1XFEBxbT7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RAPexdey; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710242554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s5vMBHYZtJxO3NM5if4qDYbHgeTRIkuKGIeNaK3F1jE=;
	b=RAPexdeywJr4+ubPUn+UK7uZVehlzFOf9gxYmV+uF75TsqNCzrBqqfGgPmlHv58VXj4eNB
	UCxpnca+19tEphanFdQZTde2335OaeAAIwPfXKDAianEYeSYzLz/Ym70njKcX92y9OvaV1
	y+5nChcsy4VdeS0eidq3zXeO52WrOf4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-QJV4YNDROMmkQl3wx6PovQ-1; Tue, 12 Mar 2024 07:22:31 -0400
X-MC-Unique: QJV4YNDROMmkQl3wx6PovQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d461a51d4aso689721fa.1
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 04:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710242550; x=1710847350;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5vMBHYZtJxO3NM5if4qDYbHgeTRIkuKGIeNaK3F1jE=;
        b=U49ELFoglU/EMUNtyi4+Pbi1C9KLkJtwo7iqkEeL7RHGYgl8y1kUJKiDYFwalbhu/j
         3Bt3ig7W38PjM0tdhDwJA/KKaACetbIySRhZHAsvjVOXLv2cEzyuDX4XJYV1KJobTCBi
         pna7+AyJP2kpSGczVe/37T0uXWMxi1J3Kt1NftUPnyZyzKO8jZ83djfZKs2koA3wq9VM
         JYBN0TksED1HQIvSRbUnwqhiqU8/iJ7PzsF8c7KjjW9JYPQ3UBhi/Av2OFH8jwWB2i0e
         uq049XPAOBz+E29TjSwda0f3i0BF3DYVWMMlNnqEOywDeOdMn+Sd1XjW+8aksybDPJWA
         QSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXudGpcMyyLEikoWrHZB3Yk/Of2dQt0AtM2aIgfykBTH8vD0jwoTnhePPi84UbL6/V6pMTieXyifMujqlSZ8fhipY39Cpcf
X-Gm-Message-State: AOJu0Yyyj6Y99om6LWWuLJ98ap+t/QPpG14MSx0hgK2gI9boEhDJptis
	Oo+jaItTrghjvqoOur1yXQjrE2VEq/kFMeryrjsm6Vpyx8AGALGMRvB/6Sr7Gd1ADD4PpJU/Md9
	9G5YgfjDnvcyjFi08dDrupovMWX6tpXuruwFFhnQlSxtV/9tP+RyVVw==
X-Received: by 2002:a2e:7e0e:0:b0:2d3:fca:dae6 with SMTP id z14-20020a2e7e0e000000b002d30fcadae6mr5374005ljc.2.1710242549965;
        Tue, 12 Mar 2024 04:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHir4J5Q85zS6G7sSfcN5fs66rJoS0iIiSOyk3E3K0WevXCFAfHFr/M4i+hQpNdB9jHRHnL+A==
X-Received: by 2002:a2e:7e0e:0:b0:2d3:fca:dae6 with SMTP id z14-20020a2e7e0e000000b002d30fcadae6mr5373986ljc.2.1710242549618;
        Tue, 12 Mar 2024 04:22:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-128.dyn.eolo.it. [146.241.226.128])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709067ad000b00a4537466591sm3763609ejo.32.2024.03.12.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 04:22:29 -0700 (PDT)
Message-ID: <570d5e37b84d5e2907e4b195d6c6df8c5e6c8830.camel@redhat.com>
Subject: Re: [net PATCH 1/5] octeontx2: Detect the mbox up or down message
 via register
From: Paolo Abeni <pabeni@redhat.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com,  naveenm@marvell.com, horms@kernel.org
Date: Tue, 12 Mar 2024 12:22:27 +0100
In-Reply-To: <1710184612-29027-2-git-send-email-sbhatta@marvell.com>
References: <1710184612-29027-1-git-send-email-sbhatta@marvell.com>
	 <1710184612-29027-2-git-send-email-sbhatta@marvell.com>
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

On Tue, 2024-03-12 at 00:46 +0530, Subbaraya Sundeep wrote:
> +bool otx2_mbox_wait_for_zero(struct otx2_mbox *mbox, int devid)
> +{
> +	u64 data;
> +
> +	data =3D readq((void __iomem *)mbox->reg_base +
> +		     (mbox->trigger | (devid << mbox->tr_shift)));
> +
> +	/* If data is non-zero wait for ~1ms and return to caller
> +	 * whether data has changed to zero or not after the wait.
> +	 */
> +
> +	if (data)
> +		usleep_range(950, 1000);
> +	else
> +		return true;

Since you have to repost,

	if (!data)
		return true;

	usleep_range(950, 1000);


will be more readable


Side note: this quite huge for a 'net' patch: it would be nice (but not
mandatory) if you could break it in smaller pieces or consider a 'net-
next' target. In the latter case, please note that 'net-next' is
currently closed for the merge window.

Cheers,

Paolo


