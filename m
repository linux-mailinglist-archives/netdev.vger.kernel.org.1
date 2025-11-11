Return-Path: <netdev+bounces-237561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18174C4D278
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E4664FA37B
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D28B34F497;
	Tue, 11 Nov 2025 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHjHpUmJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRD1sPln"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAEA34F256
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857746; cv=none; b=ROQ/oVhqov3opxZlfvLDiyBOqylOBzBx6toqIKOy8wrgKfnI5RTNdsOxRVf0/YdoQXlbWXRG2Kcm/xAqWtg3cScqlW1q1W6CU2Hb08C3d6NB6HcU9dpQGSpW9vlNlRD+2DuUmM5uMUtDlGLLZphuhEocKd9yxf5YnAkOXqeyhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857746; c=relaxed/simple;
	bh=a6nv63g15xZWAV7bVcMWY6pNkhiANyeoNIIE8kwHel8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEzWcAaKym33DoSKafAmM3kwJpeGT+tnswutsp6XxcwdqKtpiHMVb8vJoof8t/XbL8WfealF6OYXz7YALbSbnkpyloMIUzh9M3S5jx8mqM0mxGgTfIIP2B1BcRXr+Tt2NZUPx7wCNwrXA2+LqE0+/+LajXfBMJRMrOZkfWW8wu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHjHpUmJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRD1sPln; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762857743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vL9KIlYCu7LmFDNFmygm16FGGbh7HGCYxHOoN516RqY=;
	b=HHjHpUmJeWZw42s26sYkCmc5vVowoTIj09Lczc8VJ+euVJgcPkIl6yVSu94SwaWk4io2Iy
	tawqYt51Igg2E9ZogT8GnjzELgDsZgrWxv3aFRRscWOtZuvOzVE+nfF+z8S5gazRgUOonm
	8AuAGUbCVrdq15Ez4lf6/0D4t4KVKUY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-ehfKSTfxP-aRw2mN_v_VIA-1; Tue, 11 Nov 2025 05:42:21 -0500
X-MC-Unique: ehfKSTfxP-aRw2mN_v_VIA-1
X-Mimecast-MFC-AGG-ID: ehfKSTfxP-aRw2mN_v_VIA_1762857740
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477632ef599so3204365e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762857740; x=1763462540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vL9KIlYCu7LmFDNFmygm16FGGbh7HGCYxHOoN516RqY=;
        b=WRD1sPlnbwK0VQqaRYtuY4c0tePj2TuAPkt/kXH+gKi+8vgHfzltC/bmCqzVMdpmbV
         +CTXTCLX4HVs/YbWgm7C6hr4XKI75QYbH7TCr0xXyRCl+lvMIY04M4EnFP0FDKXb26Mt
         Yp7/+KHRlklc+cJ00Zk0imRfh3QEqX+l1dbq+qk/uozMlSI439emAqc4aG+5M0hW2jtY
         mqKrzu63BLH4wr3NdL1csdXpFJswm9URF6eDhpN1VugOpkrtY/f3Iap0T/YIwgGcwije
         KIbVUVGDlV0vPKKoDr4aZ+8y6wuz6cQ2zB18uayeCae/Dc257abcD/24kxhiGEnfwlmS
         2D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857740; x=1763462540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vL9KIlYCu7LmFDNFmygm16FGGbh7HGCYxHOoN516RqY=;
        b=OT8XsJJa6DsASfsO9Zzy1lXU2PP8zNFuKA5VQtfmmNYKh9Kb3BgzHmbBKHk2cn32lg
         Ko0wNnfGsVRbOl7sucqJ8o6SIAqRRQ3ACzxyfxYkYQeF+2k3N622jtHenAZQrkvsVWiS
         Ov1jD7J0OgdlM/uPbv/jd+wjecuAibVsaaSFg+Sc1AlU5xyzXqg0UDiwnMSD7loojWft
         nZdxY6IxT1U/bFa7JrmgZ4Epa7cTgqyU52YPfNLF0Pma3IoltVarWDcmxgsCOQhKwWhs
         i85XN8zJn1abMYwgORBAS4G0ht5lQfutPlnINdip07ViCV4D/7HcH/6FcyatPZcApvdW
         svUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD8J4pUUB1pe7IscpP7I0DDy1oy1MrXCFj/2s/Uu461Sx+36uTwGbUxyYXL1JzR5l9B8aVh+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcyiQ7LHVSdPFQg9OLWs87WWgtaJP3sJ70U4Rv8jurLJZtLd6i
	WlhFjs9FYU4fWUlidm3mX3I1nT7MByS6dNDvY//ko7ULYwgHf6gG16jIvuMBYhfer4W4HMFrH/+
	eOOuljcNMPa6Ank0ayExfPTt1UqyVCXQOjcjSQXhg1MnT8SLW+chv1oqmag==
X-Gm-Gg: ASbGncsPlPmHaZ0x1E7BlhCh3lUeN9su59fdygR6Fk6AH7Bc3riWs78Q0lD6NzK26Z3
	9/mf6YelWRr9BCqvRwbgxHtZtL+yC+68w0JZneZVFg3d5SJULSlaJvZ0/jMq/7Q7Qu9kZSl5FCy
	u/UzJ8FmGjYo04NL3k5WHHsSsRFqtal+JiqbE2IG50mBGka8QAej5Xv9EVhIfep5xzZVcMc7+6y
	z83qvWMS+Fp0MAO+9UEgy+RgBcGCDbvR7XVheZtYA4rpDQ8ak3W/oGIIch6IXBX5rlV74rxVlO0
	h33O9tGnsSQo7oPwDu/Nf4IGIs2W9kYrNuFHwwQXCrbKsp3O0sEqeDUmv4Xv/GGPjUk38VN1vNh
	NyQ==
X-Received: by 2002:a05:600c:3153:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47781442334mr21632335e9.17.1762857740319;
        Tue, 11 Nov 2025 02:42:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE39SXXrwK8KEb+Y0d1GKp77tLD2dthpm61pCGxbtS2FZaUq8fCZ+9TOrRsqQgjJjyoJrw9wQ==
X-Received: by 2002:a05:600c:3153:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47781442334mr21632115e9.17.1762857739945;
        Tue, 11 Nov 2025 02:42:19 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477632bda1asm301364145e9.3.2025.11.11.02.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 02:42:19 -0800 (PST)
Message-ID: <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
Date: Tue, 11 Nov 2025 11:42:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter
 caps
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251107041523.1928-1-danielj@nvidia.com>
 <20251107041523.1928-6-danielj@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251107041523.1928-6-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 5:15 AM, Daniel Jurgens wrote:
> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		goto free_unregister_netdev;

I'm sorry for not noticing the following earlier, but it looks like that
the code could error out on ENOMEM even if the feature is not really
supported,  when `cap_id_list` allocation fails, which in turn looks a
bit bad, as the allocated chunk is not that small (32K if I read
correctly).

@Jason, @Micheal: WDYT?

/P


