Return-Path: <netdev+bounces-224070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D98B8071E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB291C845BC
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB282D061C;
	Wed, 17 Sep 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPYU/kzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72428489D
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121385; cv=none; b=jhFIvyfiQPddzLGejXsgIJr1pfZhCCuAF+ek1DpUeuhZbeor8Rr2v5CTNLJQ8tPCuwJV9I8e9wmKHDxtOoOpMTQNR41U+90G0ArtO79Gyfhc3s3RufGX7mWvF0deRIFOu310Lj5CGr+eU1g0JTcs4U2Ohe/I5VoVnGx3eMYSnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121385; c=relaxed/simple;
	bh=HF8kNJv4lVrRmJ7q1k2rSiCZ/eCD5dt9y3DXzDVC77o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MSH2VFnkBkNCyAhT2NDs+/ICzXRxxuh8esv3wUJurvhS5N5KqvLmckyefw2XwJSrVp/sx/kO0mPFFdJyohda3hZf3gz37y4rL59ZLPcnG1PBdzTWqGWg2ETVwYSYkeHGE8s4T0xlkpLXTe3B+Dhf4muyFCDzUP1VKsGOWDM5H7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPYU/kzi; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b795fa11adso25118991cf.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121383; x=1758726183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PebGFnWLVUBJiAfKsGFYmeK/5Ld7FsGOgGnWpJyzJQ=;
        b=hPYU/kziqnk0k+5/VxndQU96SmCINXNdi9CblX14f5PNdYAOreqUp3YsA0v7EhUknK
         51JFKDxPTUNWly27Y4Mh1LU/QQcts7IZlp88D5QoKYpZucQilhDAXpEkkreEyLhKx4PR
         o016i8omnLXshlfUtGV3yhbP1zv0AhsWTOUtIRkmcAB5VRGfsl5x4ZA4k0rbiQ+AeNFt
         jfs6uC4DtXOhWF50xmCiKq20QRPh+Vp3KFhcHLYcG2yITzGPYwUku+lxQLCsPJtWyTEl
         cqRbUIT9WELeXbIK6XSo8gUsyYh06KKG64JFduc0I4FvsLZ/F1Rcxu5GaFnWHr8WKHFg
         Y4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121383; x=1758726183;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7PebGFnWLVUBJiAfKsGFYmeK/5Ld7FsGOgGnWpJyzJQ=;
        b=LUDcNfXpDvKEy7apDBknd/9CrdO+p/gJyOhPH7SpeFyqaIMQE3AVZoJuN429RYjC8z
         7Szk9wkPQlAxXN1nM68l59qSwWOXRGloXleCWea2f2ThEodawAio5oj8rgfAWbIo2o5k
         JQAl4o0AUqt2Ybxu4e2IuQi9n3RVvri79a4vGx1HfBl/HSAAS+ISTqkNzE+HW13E3zJk
         ZT4K4Iq4l32oGzbEcDTii6xUl1u6+/G0Fjpu4enyenO+SoSMK6UUOf1gWP0uSmxkwcOu
         nhjAaBCS0W9MJHhQdWTUizT7OHGqJcBN7Ugcr0a5MKGAk2GaGI0MPif6cOc2QnMmBYjP
         2BBA==
X-Forwarded-Encrypted: i=1; AJvYcCWfXvsF9x9An5vByQaLKKTgrF+8ciG0NXg7SVFLSOl2Dpfx+0GeOxx3oX5iX3vF2Iaog/l/qhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2lxZVjrjWliO4CMk1p/kI41g/gE/c1t9Wa8a7G8gEiq2NLUr
	a1vSN35vk8Kbzsz+q2JQ8fPfF7Lim5s/8uPznQm3CzpCbBFsVBXYdykL
X-Gm-Gg: ASbGncsgkXuW4Pf9uAz//yZ+1kO2JfYzEE3ecS0lZw03zdeMYpJTzC2n12bvazVMirp
	7TD0R1fWLrTR2uooLX94dWPnGNLr4mUXuahCJnun+DRN0T7UhyE/UkIF4xaQQLpj5Q3oF4OBk/n
	I/skyupW9z19FGBzfVKVSYTN/hP/GCR38eno+GEHipDlO8TuQddP4sRI6hN9I/yCxhrEcV6Gke5
	uHpPnbTUt7wTRqWN1sai2L3eS+LW2D8hfwnBKwU33yMxVSsLOUQpIQpyEB0cp+JFJXP0wyVvQc5
	6Kth9JP83P5iPkeXeet3uFJgkeedT465kMdY0krw789sdeYN7Q3RSopN8rn6CZEKt5M8HRILCmu
	9wPvVNx8z3enZn9rU8VaoCMUtl4NGr3C3BXXWvz/cZAvzqF7D3ejyI06t/RQydQEWrd3rariqz+
	8+Nw==
X-Google-Smtp-Source: AGHT+IEhuVSg+WcIucs3cLmPMclMEJ9c5gmDOtzJTaxO7KepkRvTRSMHe69o2VW8snqcFojhOw+yKA==
X-Received: by 2002:ac8:5f51:0:b0:4b7:9a38:d002 with SMTP id d75a77b69052e-4ba6815600fmr26965751cf.33.1758121382721;
        Wed, 17 Sep 2025 08:03:02 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639dce785sm101193221cf.41.2025.09.17.08.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:03:01 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:03:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.1fc74c327141e@gmail.com>
In-Reply-To: <20250916160951.541279-10-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-10-edumazet@google.com>
Subject: Re: [PATCH net-next 09/10] udp: make busylock per socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> While having all spinlocks packed into an array was a space saver,
> this also caused NUMA imbalance and hash collisions.
> 
> UDPv6 socket size becomes 1600 after this patch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

