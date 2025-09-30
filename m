Return-Path: <netdev+bounces-227317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF52BAC457
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0337248108E
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DCA279DCA;
	Tue, 30 Sep 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhS+iovK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052702BD034
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224448; cv=none; b=WpYtcEJ5vDX6I+kzbdmm6lsVL0NIQJvdKkpsiwIHrl+VrzuAJJF3dkttAEA4nRJCH1IwyGRwnwvsWEqj7ZtkwISJdYQoL9L4Dsa/q6IrCM5eQr5GiUhqRXnabbGlR7TJND/NdNUG0EtzdGHAeoGsRsjL4qGhYh1CiuFezN2lGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224448; c=relaxed/simple;
	bh=Yy9rsILfkCrVG1hatgRp/esDRroCQxId/1gXctS+x5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iu95Kkuqa5C5yIcCvWOFk5ffIXFXgBHpVsY1x8eTvuDgTNF1b356w7cskEG8Zz0dahcVqLvq0QXnNgu4vyenL/s7PsXyxqCd2uzplu13Ecl2IVoieCKY+tg3DsHrr7lWsCiJvc0hpEUsXWUTAvfoLEN4EUxup1ICMY1M+3t2AbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhS+iovK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759224446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhIhQ7Pc439Kte7+kbL4E23pxh4Cb2bhE5vgknWcd/c=;
	b=LhS+iovKjChgpvH542PgNQuFy6StuJMnFS+ENoIa6CGLe4EJVk+Dns8T49HQL5Cu5PBmNv
	qTRQtU2UEY0pW6RK+isUgG7VwGKJYk6C1ctOP88u4KTUfa5HxoBE3BYEi/Qng71QAR55gT
	3bwZT8MdmXM16c03ja5X2vJDayixIpM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-sfYF5VIRMpaUsa-e8Nia6A-1; Tue, 30 Sep 2025 05:27:24 -0400
X-MC-Unique: sfYF5VIRMpaUsa-e8Nia6A-1
X-Mimecast-MFC-AGG-ID: sfYF5VIRMpaUsa-e8Nia6A_1759224443
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e4fa584e7so13127115e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 02:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759224443; x=1759829243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhIhQ7Pc439Kte7+kbL4E23pxh4Cb2bhE5vgknWcd/c=;
        b=gqGnuQUXkBMPRmoceKk0t2AsqFkSUT9jcH0SaRD0CRA7BdsEswT5y8b+iXggwKn4iy
         nvPtZlueU2ZVcBv5Z7vZkmh8LA+AqqtBxCA1s4ch6ks+fa1NzEeqncA8ZbB7Ns8q2H9/
         VTo25UkExqR3ht1dYhW8esg7iiGYvy1CmSmCgJzTii5PLfOUfksm4kjo5awdl5MMSS1I
         kCqiVD8OKVb3YyCLFy7r3Pl2TmNZYpb/PsT3kxaMPbCN5290IIfU8i70t+Q8JN/NG6lI
         uWOKSfE4c1ijM4gkZbQDb4X8VT/bM2c6+jupV3tjizBMp2Y9mGQMw8DAmmht1UrUmGt5
         y9Gw==
X-Forwarded-Encrypted: i=1; AJvYcCX23AV6tnfHC31bd8u9qGQjTxAhjFfMU7NoEYLy65iHLmvl6nesEtic9LpoAFUk/ApHB4uGNZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcaSoDkKzwZ1Fjxpzunv9ZEhWegQ47WlW6DtsYmXNz/EPvjaq
	2DeFu8pwQPoB2xdBSQd/biHKhh12vj4nVxkziMu77DkX4PwsO5l4ov1l9L3B65eauxmmOXuLs5D
	ZHErlQefeOJ2cLcIuTPMrtZ1wpc3/gaOEAjKthC7AUVlCPe11FFbbQ6VAfg==
X-Gm-Gg: ASbGncvpd+ozcnCdbC720aG49C+SQyVO500/8wqiR+Q+M3S1nz7b6iLB8VFXbnAchrF
	UMiTBTuJIStqdjzeSSzyq6ediRgsJfYwxuC+GkvMGIOs8lmdglH4Do9hDjGtVMnpbPzMf2jGgYV
	5ECKuPib0rDbm5apzMkESJepOzu25jy1AP/uJU3E6dDk1QcASARW/xooWDU6458sD+IdTED95k3
	/wl6Tb6JV3FZApAH/FgzOjy9ABReHlwcvkFHm+axsANXCTB/f2tKKhtFXiTMzM851IrXoX22R96
	kfx7u/xP+WZCagU6eRockt2MSSM/BckdBoOm5PJt7q913dY+OeMjt5TYzjYZD1DvW1av0tcPnyw
	A7UHXBe7NNoay66wgEw==
X-Received: by 2002:a05:600c:1d89:b0:46e:4925:c74f with SMTP id 5b1f17b1804b1-46e4925cb9dmr95025615e9.20.1759224443083;
        Tue, 30 Sep 2025 02:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyrYLqjJuBzJIHajHdtgs/fUkc/rxcVHHrAN28ev0rPW/mh9TSEk3RCtEV8V90gd7i1h46JA==
X-Received: by 2002:a05:600c:1d89:b0:46e:4925:c74f with SMTP id 5b1f17b1804b1-46e4925cb9dmr95025345e9.20.1759224442723;
        Tue, 30 Sep 2025 02:27:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb8811946sm21749722f8f.18.2025.09.30.02.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 02:27:22 -0700 (PDT)
Message-ID: <2c1b5e2b-9488-4a0c-b0eb-c29527d618ec@redhat.com>
Date: Tue, 30 Sep 2025 11:27:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
To: Hangbin Liu <haliu@redhat.com>
Cc: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org,
 jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, stephen@networkplumber.org,
 horms@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20250930012857.2270721-1-wilder@us.ibm.com>
 <6be07cb6-7dab-4125-b9e5-0bd4c42235fe@redhat.com> <aNuNwyRb5nEsAy-z@fedora>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aNuNwyRb5nEsAy-z@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/25 9:58 AM, Hangbin Liu wrote:
> On Tue, Sep 30, 2025 at 09:21:30AM +0200, Paolo Abeni wrote:
>> ## Form letter - net-next-closed
>>
>> The merge window for v6.18 has begun and therefore net-next is closed
>> for new drivers, features, code refactoring and optimizations. We are
>> currently accepting bug fixes only.
>>
>> Please repost when net-next reopens after June 8th.
>>
>> RFC patches sent for review only are obviously welcome at any time.
>>
> 
> I guess you mean after October 13th[1].

Whoops, bad C&P here while writing the form letter. Thanks for catching
it! To be more accurate: after Oct 12th.

/P


