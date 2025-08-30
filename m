Return-Path: <netdev+bounces-218455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F0B3C792
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 05:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799B7583E0A
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5978F19DFAB;
	Sat, 30 Aug 2025 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="BEl07O07"
X-Original-To: netdev@vger.kernel.org
Received: from mx.scoopta.email (mx.scoopta.email [66.228.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA11168BD
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756523876; cv=none; b=uZmeeD1kLPv59f8kAGoPMRIQQaqItcPExCL+eXCpdqmltZLbMsz9n8OpkxblMKHHf/koMys5+ruW5lZU12N93xnzQHydal1HN8w1QaIBXpszCpZNAo3ugt/CMh/kXMyT/HeOPE+x880Dh8ZvFsFNe1VBx45Cp/QCrP2RgB6qYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756523876; c=relaxed/simple;
	bh=9EpYYWx49018hNlupAUoHS7dOGwTOh5W0LTdg3gHbms=;
	h=MIME-Version:Message-ID:Date:To:From:Subject:Content-Type; b=Tri5u4fxzvBiGDMqYmREY0q5tyc3gFOdgJ8cxOOUhhFLYlNQlgM6Bva4clbdGM6Ljd8prFrGO1zdTXarabFAw+e5ADYInwa2ro73bXkYL5bAVf4fS7I+xrYrwuzQ9acnPB9QU4wIW3CG7N2UBfD9nzWuPfLHjfCjZtq0HKKeZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email; spf=pass smtp.mailfrom=scoopta.email; dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b=BEl07O07; arc=none smtp.client-ip=66.228.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scoopta.email
DKIM-Signature: a=rsa-sha256; b=BEl07O07IZN68wnamqpk2D1d5w94FYjrQgrmN/LUTs8fD6AOC1dZ27wYpGAkvPYsHb0HWtmyyBji3wFRMXpS6ZZFgxRqiB4i8t+tzK7sVH1KeW8DF/i9DI7D0f8mD9TAJgcOHGqRyYvMZdnVZMhyv8ABCwFIhxUswiWmKZjXYz/uh6dWVAesV/RfPmFUMklWVPNpVAOvWDvosKEaheyHJge+aFfSQp5iX1gLl5rZPP0s37ymYgy3dBaB0/eD860Pdd4WXSp0RC7LD2mGiNDmzX7pocAfY74Xx8jRH+7+YfX29MDYm3nZc+4MqWDzhvth21xOK+NbOwWP5bU08aavR15wzVzazN9Fy4kwmBcrxHmxrhTcM30f0woiy3f7z9o840z2QWBq3zsSBflGsSWEBzsZX4aHF1usX6zjQDRgG7U0e2ZjUC2eeWMWMPXoXfXjRaOIBxKvhXQFT+26M0r2vmbJSK1Nb9QiCK9ys9gH4itNABpArtSWD1wFBvcOTQjzHmeTXpxtWz8umc4l5fb1KB0y2sw7xG8SsZsmTLFkNHhN1BdhG6mYvpxQvTBXERyFfjkwI6Yv2EsJQZRK1f6oKoLcyvAP9Blzvoog+XAvGfNEs89ikj7VYVATA6GUn/335Bl+e6ZL1PYi6ITfrGmWXs5EXkdoxXYVLAckLmIpmvJp/AIRDLj++noxqqTN+MPCNFmFo555F8kEBKXvsJQiUd6WCeGxfU89GaRPoMrgfAf52pBOQuaGiFkl2ojSKYoue+kc7ejmZyzzSr4qg+mKzDFsg/CIpdRl3tDTltkLuXycoufzy8uJbszmFlR1/a/N8seowrAw8X7lxNxUlu43iyfBdQVzlbe6H8VKl5nNxQHO7x055Ryq5hVFdlnH+pfsLO6bCn4ZA6Xu+WCeBhMKuAAdeGqOAhHCIfs6BnEFOzJgsOnDDoVMZ/5YhFSAnE1ozyXjoU
 mQtTIMs8DIOtwdBPsmdWwnLC3Y7V4BTzc9tuA1rgbwmqvpZLlq3BqKML7jnVwaOCmhBKFm1XdjJfzSupA9yeuXLurK/PVD3fsnSyyK9VwyQhgRa0C4azvOzfm7bWfbF1ZGgm4NtXvrffcm8cGsuZX9eZrLCL+k8it/K0dVEALdlKusNPN9Xsk9XwWhmKKuag1iengkbWlybqeY67snWcsINRBkHXi9lIQRRYTODJXWPfHQHwGzE4QkVhsT+PXZf60b59ZGvp06DKx0KFRZP6I6YzIbThoBjnsfIYGJwMu+oNGWmzvPI7KIRfVYtC/Xw58d2V5ik7zPHiViiZWqIikG3EaIHH5r1hMjXLxvUk4lJIWHIHY4E7SjTqtN4v/PtKoViJU+tn9EoE3SMA==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=+g/PGGj1hT8B0BkL5YMGFsC7Bp9SE8LjCwk0cXayT4E=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-UserIsAuth: true
Received: from 2602-2e1-80-1a0-640a-ab0b-2156-2ef4.rdns.uwunet.xyz (EHLO [IPV6:2602:2e1:80:1a0:640a:ab0b:2156:2ef4]) ([2602:2e1:80:1a0:640a:ab0b:2156:2ef4])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID 1480387565
          for <netdev@vger.kernel.org>;
          Fri, 29 Aug 2025 20:17:32 -0700 (PDT)
Message-ID: <866009fe-e88a-4d4f-8ff3-34e0cbad3caf@scoopta.email>
Date: Fri, 29 Aug 2025 20:17:32 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Scoopta <mlist@scoopta.email>
Subject: IPVLAN on non-ethernet interfaces
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm trying to find documentation that explains why IPVLANs are 
restricted to ethernet only but can't seem to, so figured I'd ask here. 
Is there some technical reason why you couldn't for example attach an 
IPVLAN to a tun or other non-ethernet interface? I'm not familiar with 
the inner workings of this device but at least on the surface it looks 
like it should only care about the IP address of traffic and the L2 in 
use shouldn't matter.

Thanks


