Return-Path: <netdev+bounces-106442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04049165F5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B05B22915
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C8149C68;
	Tue, 25 Jun 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1xuxTzd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAD56CDBA
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314248; cv=none; b=gyx5t6IGJUoaozACzYe87Yn0UVEgosmYUnLfZA40Z6WflGc2Aa7uC0mBQVCbX6O/NwDNSnggp8BEU9BSVQD5hdCW8w7N/FrmbEh089z1ibIWPJkLfEpF0ooIpUMTSrM+iiohZpzKyPB1nntkYoGAGDt06LrvNOj8dhrESVAk/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314248; c=relaxed/simple;
	bh=y490bPhOlcUj6oMcNqbEbIHKwi+qcAu1wSEKHBpcp+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwkUh4jlfH9vr5/YEkXDIP2UaHzwMg6ca42z5q7f9yMQWkN1ORX+BFrNxB5eh2UhYyKm0xx+icFJAKXOdH86yksZpcmOnnZIobkuTca0rRiFibonb+gqxTRHwLTkvAZ2opWR5/ZG5rd/OoH1dXcKsrNFQwquYdX10RGzyaEWZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1xuxTzd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719314245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2aLXgwLy3k7Kem/gMkVxdLW2kTd5Zk6l4rzy7cvLwKo=;
	b=f1xuxTzdIfxfDK5/cWKTmlF5+bLrBGpNXxOVw0VO27ekd93Xy8UgJW0ujxC6aKV3DFexmT
	tqrh8WM+8sADLzYr553wjq2I+aSkCxG6OTFUIwridsrqOJbgVEmkrSQEYzs3/sTvTBS8Bm
	6sS7by2DVWMbd9v5GyF59Wu+tDGECzI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-p4ZOCd1RPH6cEG9XKt5dqQ-1; Tue, 25 Jun 2024 07:17:23 -0400
X-MC-Unique: p4ZOCd1RPH6cEG9XKt5dqQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ec4f662672so3022111fa.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 04:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719314242; x=1719919042;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aLXgwLy3k7Kem/gMkVxdLW2kTd5Zk6l4rzy7cvLwKo=;
        b=pyG+i5HHTTyCYLhmM3JK/ppBX1yuRWvA6iwR6sIEODPH57JDo4fR8GdJK7iu5nAfdh
         KESR7BqQNAGF39d+f/IOmhVWGxx3gltu9bQm6fOU6wbQ7zrKR0KuAXomI7vVeZgbbJ3p
         4OtIFHbJ5BNrd2QSfvsyyib8kZ70JyWBHg9nNHsqfkbW6q2tpyROy0p4ob9T+tRVsy8V
         JpCK3MZ8HIT8kYBTK5FOM3mk/mGR9TiB9UJo72ac16NYR9uwx7KlG5+fTF1C/1HOExjM
         KVEOkwWJR/x7+8T+Vo7AkZ4Tk86QkS3NW0CwH9rSiNt2XvCVc8ZJtRciumscEU/aRdA/
         E7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUeAgjXO8oLsVMSgKjhTuOUMyjsZiCQ3CMKWFhWagbChMb4p/FnHh6drI0BJXVn3RYuzQ8J8LaR+VTmt6mu6kLVFfSgI1ju
X-Gm-Message-State: AOJu0Yx4J7nMSunxLwMMJx59tNbAtBr+DqcKM5VqFVSXKlEaIraZwuQo
	dWSxlIfWvwWcx8Y3geDTmXXSgR/U/cTJyGS8FGR5dhUG1sYewRQHAOjvjc/YKrqFig2PHYni9s+
	H9cSb3Mu6NywXERRvespmMdak1MAhXCuCDG3Zx9V+5gdwtYhS0vjk+Q==
X-Received: by 2002:a05:6512:3d0a:b0:52c:dac6:107 with SMTP id 2adb3069b0e04-52cdea9994fmr5745045e87.3.1719314242193;
        Tue, 25 Jun 2024 04:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEl47EgU2487K6uzY/mUSiz9yUIgDQlD0gWBbrtXxnvHFHTHoBrINXJMvqf+y9sKohrsRwPA==
X-Received: by 2002:a05:6512:3d0a:b0:52c:dac6:107 with SMTP id 2adb3069b0e04-52cdea9994fmr5745039e87.3.1719314241787;
        Tue, 25 Jun 2024 04:17:21 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:da10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42481922774sm173756155e9.47.2024.06.25.04.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:17:21 -0700 (PDT)
Message-ID: <7f6aa18e38ff3c161805b19780c6265d05b4a235.camel@redhat.com>
Subject: Re: [PATCH net-next v4 04/10] net: psample: allow using rate as
 probability
From: Paolo Abeni <pabeni@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: aconole@redhat.com, echaudro@redhat.com, horms@kernel.org,
 i.maximets@ovn.org,  dev@openvswitch.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>,  linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 13:17:19 +0200
In-Reply-To: <20240621101113.2185308-5-amorenoz@redhat.com>
References: <20240621101113.2185308-1-amorenoz@redhat.com>
	 <20240621101113.2185308-5-amorenoz@redhat.com>
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

On Fri, 2024-06-21 at 12:10 +0200, Adrian Moreno wrote:
> diff --git a/include/uapi/linux/tc_act/tc_sample.h b/include/uapi/linux/t=
c_act/tc_sample.h
> index fee1bcc20793..7ee0735e7b38 100644
> --- a/include/uapi/linux/tc_act/tc_sample.h
> +++ b/include/uapi/linux/tc_act/tc_sample.h
> @@ -18,6 +18,7 @@ enum {
>  	TCA_SAMPLE_TRUNC_SIZE,
>  	TCA_SAMPLE_PSAMPLE_GROUP,
>  	TCA_SAMPLE_PAD,
> +	TCA_SAMPLE_PROBABILITY,
>  	__TCA_SAMPLE_MAX
>  };
>  #define TCA_SAMPLE_MAX (__TCA_SAMPLE_MAX - 1)

I believe Ilya's comment on v3 is correct, this chunk looks unrelated
and unneeded. I guess you can drop it? Or am I missing something?

Thanks,

Paolo


