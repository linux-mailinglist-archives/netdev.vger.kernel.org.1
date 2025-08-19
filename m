Return-Path: <netdev+bounces-214969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7CDB2C594
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AADA24638B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCCE2EB86B;
	Tue, 19 Aug 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQAdYmvL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67D2EB868
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609733; cv=none; b=Rox+yjSc5FWNM3WhYALQCqyULJphLQzYtkV89qw6gwQ2fbIgRkiqRqDkXo43jf2QjgCrmYZ0/h7I3SYQyENyS+AG35PqA1zC7b9+ymb4/PvaRdlOVp0sDg/gyFFUl7y53r4cBXQfKZXYtTJg4ahNKsd3yh4pLhMdgHPHvQzU9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609733; c=relaxed/simple;
	bh=YGquTGErfZMK4Z8mlgqCJLtgMJkYfu1aCh6sBFItdVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsVBU27CTA+onHn7C4Nj//vWlmRGo80DoY7+m3m7QhQwvAfBcWEl1XwqSrpE6fqpJ62KDBGcH51FQAeuS1Lj16bpF9qH4Gnbt+RlL675zUIBRcWEcCIJFyRgUuCIxT5iBRKE+vfEupQpk3g0IThClv3bFGcyjBilqQ3x/RUMK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQAdYmvL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755609731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nywEW2vKiMccWYiE9n53wSFHnhrNtVEYY4SxrJi2fuI=;
	b=eQAdYmvL95Lqd5ITzVEqumkwp0DR4dRxAg3Yzn8hLICAfKbVuVNuKQk26YkfhOZSOtjrKs
	qm4xjW/VgbqoS0sYYVksl0h0PPVLI8tmZCybelMMzGfQasPen/RfkZ4s9JKhv0X5Ic5RH0
	W5bnKkO6zotVxtRfKCGuzkk1yYTc3nI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-fY0PUV2oMpuKQrfJ3uHT3w-1; Tue, 19 Aug 2025 09:22:08 -0400
X-MC-Unique: fY0PUV2oMpuKQrfJ3uHT3w-1
X-Mimecast-MFC-AGG-ID: fY0PUV2oMpuKQrfJ3uHT3w_1755609728
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e87068c271so1501745485a.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609728; x=1756214528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nywEW2vKiMccWYiE9n53wSFHnhrNtVEYY4SxrJi2fuI=;
        b=UPGSViaHAKl6tiS0Fkia5t/iafloeqX+DmHPupUOZ/IrrJEHUlbPNkFj4Xz31Bdcry
         Mk/xkXeGpWZhR2fdpRBSaZ+8HSfaGtBAwOtBZOHIiTpybDxXRmXCYrZCrmxn++i2uep+
         laMoDMlZSoeSZwtfqudGLYUSUZ9K9FwiPfML3HJ3fyLWmDSCEZ/zcAi0HZK1lNpu8owI
         Qk1dlpETr0NteCZADS4Ubnn2a60wGGe48R7vjZwwTHl/Y+jJGZPMwbPI2kraNDlYYjao
         uaJEeFMwmPMQZjcV+j2DP/3Kcw+C9zbL+rqa0tPhaI/Tp72acZef3ePVBqNXwQC3krV2
         BdaA==
X-Gm-Message-State: AOJu0YzkeFPKR7T6ojIBvvoaP5bU7VJugIKX9lNrZValihO9Lnrk20VS
	IiLzQvM47OhYAvxq6HEIhES3jxssbszZ6UHOGAKY89E6Z/xNwBjHLpmj0mleYEsC5QlWTmBbdfa
	SjBZeMyQgOEv3cXwrEyWrtXxI5qfzkwU5RaoSp6cJQQ7sMCjgqkCy+I8K5Q==
X-Gm-Gg: ASbGncvOjLJ2em9RE96+EVUNHFQAee9tNKu4jq291DgoAoDKMkf0jYHylUSGoDTGDNu
	NpbJmbZ59EktGqDRTE5BKiqs+RQRNSSmYgyNpxDWD3qb9igYjTWezJNk/sg2UZxr6siPAlljwKC
	CU8Lv99fwvJxMoeZxUXec3giPNsei8Mw92rDFIC7usXbvItws4cjYkCGwh+pEf3c+VaNTJ0JnPj
	6WUXe60F1UA1KnfIqRWRA2l0eguPIJDXLDVhK5Z4g2FI3mNpqsvRTQHyJcTIqaLaP9ZFydL9WbC
	7H0IEpT3TnZU17k2RBE5ZD1J4JoU4PvZxpHoo/O/7Y+t8QN0gWLaZuKo1tUHM5qEfzCo3C/4oJ7
	4h0cv2ESkK1Y=
X-Received: by 2002:a05:620a:a48c:b0:7e9:f81f:cea5 with SMTP id af79cd13be357-7e9f81fd1d2mr96853485a.83.1755609727414;
        Tue, 19 Aug 2025 06:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6F35u3T+eC+dnHWwSRfGoWO9IfLlxyoh2o8GvCu/FrVeuc4uL/zQUhn/LcS2bYYks3YKIOA==
X-Received: by 2002:a05:620a:a48c:b0:7e9:f81f:cea5 with SMTP id af79cd13be357-7e9f81fd1d2mr96848185a.83.1755609726732;
        Tue, 19 Aug 2025 06:22:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de50b31sm67890121cf.51.2025.08.19.06.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 06:22:06 -0700 (PDT)
Message-ID: <715111b5-6cd1-45c0-b398-b5d8bec7f24f@redhat.com>
Date: Tue, 19 Aug 2025 15:22:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 1/8] hinic3: Async Event Queue interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Fu Guiming <fuguiming@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>,
 Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1755176101.git.zhuyikai1@h-partners.com>
 <4a3fbb9455305898257760e2a13cc072b475489b.1755176101.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4a3fbb9455305898257760e2a13cc072b475489b.1755176101.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 3:01 AM, Fan Gong wrote:
> +static void remove_eq(struct hinic3_eq *eq)
> +{
> +	hinic3_set_msix_state(eq->hwdev, eq->msix_entry_idx,
> +			      HINIC3_MSIX_DISABLE);
> +	free_irq(eq->irq_id, eq);
> +	/* Indirect access should set q_id first */
> +	hinic3_hwif_write_reg(eq->hwdev->hwif,
> +			      HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
> +			      eq->q_id);
> +
> +	cancel_work_sync(&eq->aeq_work);

The above should be 'disable_work_sync()' to avoid the work being
re-scheduled by the flushed handler and later UaF.

/P


