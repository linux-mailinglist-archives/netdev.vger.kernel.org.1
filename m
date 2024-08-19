Return-Path: <netdev+bounces-119715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D4A956B11
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DF41C20446
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BDA16B3BF;
	Mon, 19 Aug 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDoWFCsv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4616B396;
	Mon, 19 Aug 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071317; cv=none; b=A3i6edVIPCG8kND5YsV6DskQK2+yJI9tvJ1rvad/EebNqfDb/Yf6NTqccAMX9h+d9ihFEzg81wsZGCpOELnOK552i0IyNM2wH06ykx2LTPIUM7Xkl1Tlgp6+0rEMj/TaOwb3n1flD7xLhUwBWPIcL+mS9BW1dyo5AuheVCwo1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071317; c=relaxed/simple;
	bh=HkorkWo41c7o1W5la+gTTbeuOE1bBXcPoKgZ7ULoVb4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZoZYs1lngX2VuYXC+4eLKqNPDWeWLnwdFOiQmndAdOVl+VwQJqwcf+VSA/LS0LuX43WNkzKdKJyaXraTw4mJYmbXXbEaRE0qgyRoIGnb6gkPdT6vAM0zUDZtG+rarfHnSP4vBCcinyGrApzfuFsK7MTj/M85pr/cVwTq6+JhUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDoWFCsv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20201433461so1041725ad.3;
        Mon, 19 Aug 2024 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724071316; x=1724676116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egIIq2Tij2yZlcDUiB3SS6h443dfxA40vwxckLIt5Xk=;
        b=hDoWFCsvFG9i0JLewgiCj0n3aistsdQp4W2AslAPu2l82060tWCVDzxuTVArlvwPDK
         spgz4e7gty2MCBrY//L2M58qjReQ/T+SYyFRlGfzwG1rlkYg1otkJjxmnTix8ieWeWjt
         d7Iht8xKgdUZt68t1djfmUBDx/1gfr6DmiiEsTqmRbRWheCrFDHWgMLFcCTYa/jf/MJi
         Z1LgsXAIEFUatJtk6z/69upJuLiB5pH9DLDJ6VyJO8XApuyoK4sQ+GgP7zcrkAZcEQHT
         WGx7+WFECRUqzntb6iK4VWGMykueuAONW9w+6xCazLnAIE17czkNLHva6DaR5BxUwzuC
         HJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071316; x=1724676116;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=egIIq2Tij2yZlcDUiB3SS6h443dfxA40vwxckLIt5Xk=;
        b=DVeaSagHEajHzYlJVX5CE036n1zt7YTA5vmb8gn8uQEsh7BW8Hrx6+BdgsHCxtE8Dj
         h5EKOdbn2dmIrCwVuIy0cR04ofcq5+w1Qtw0Y7Axa4cqe914qQOT3sfazYVnN/zNgLsS
         XXTpR/jT/JpPVwL1KE1/7ApTTAcET3zJjz6UpgJ3uLZ+RnFZxkWTx4y48PtngEk3nvL+
         lft/stE3n1WiJAsbEh6G+QmRxZcJkjIU/enVxV7Uim8ZZ6GY4LFFHXYv0ejUG0Fiz/ae
         BGwR31Ia0eqP+GWe0reDG336N3jryXRU46ddU88rXUn9roZz6U3ziXtKWATuLke6jYFe
         oylQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFNG2Xw4E5pTqHJvjIwOOZnn9DZltO6hDWV04honAPAkAHz9jtAHDUtMcWQ3ekz8rTJptj5WU=@vger.kernel.org, AJvYcCWusZ5CZDjW6k/ol//G+gnwWz+3THfEgZYKsYmf5COv1cM16upUQUKX2hJ0jOKORZpiRpStDkYngvpWwGsQZgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweYru61aju2uYU+0b4DL6UZjMzm5UfkpSPhM5NlnoEGkJANe8J
	HLEHXIAW5uX7Qrtb69StJPq1ksO9NNGwIVJx3iEQpDjIqTykgbmd
X-Google-Smtp-Source: AGHT+IGD5oXHKY8DggbLbs8785+A8clBy8pdJNgZXfBNsRUm5YwKDS1Z4yCcAFD98Yp0yZ0QWfC2Ww==
X-Received: by 2002:a17:902:f545:b0:202:41cb:7d73 with SMTP id d9443c01a7336-20241cb80c9mr20775625ad.11.1724071315637;
        Mon, 19 Aug 2024 05:41:55 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f022c72bsm62249535ad.0.2024.08.19.05.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:41:55 -0700 (PDT)
Date: Mon, 19 Aug 2024 12:41:52 +0000 (UTC)
Message-Id: <20240819.124152.1149996909347890108.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v5 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47s6oscYosRT-xgdTtC_4SG7W2iwEzrB+7w0Bc=P4G6tPw@mail.gmail.com>
References: <20240819005345.84255-1-fujita.tomonori@gmail.com>
	<20240819005345.84255-4-fujita.tomonori@gmail.com>
	<CALNs47s6oscYosRT-xgdTtC_4SG7W2iwEzrB+7w0Bc=P4G6tPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 02:21:03 -0500
Trevor Gross <tmgross@umich.edu> wrote:

>> @@ -76,9 +76,11 @@ impl Device {
>>      ///
>>      /// # Safety
>>      ///
>> -    /// For the duration of 'a, the pointer must point at a valid `phy_device`,
>> -    /// and the caller must be in a context where all methods defined on this struct
>> -    /// are safe to call.
>> +    /// For the duration of 'a,
> 
> Nit, backticks around `'a`

Oops, I'll add.

>> +    /// - the pointer must point at a valid `phy_device`, and the caller
>> +    ///   must be in a context where all methods defined on this struct
>> +    ///   are safe to call.
>> +    /// - `(*ptr).mdio.dev` must be a valid.
>>      unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>>          // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_device`.
>>          let ptr = ptr.cast::<Self>();
> 
> Reviewed-by: Trevor Gross <tmgross@umich.edu>

Thanks!

