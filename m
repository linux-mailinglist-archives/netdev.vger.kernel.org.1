Return-Path: <netdev+bounces-188872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EACAAF1C5
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E679B167E47
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC7920299E;
	Thu,  8 May 2025 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4N7tAEuw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F01FCFDB;
	Thu,  8 May 2025 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675387; cv=fail; b=En4rCaXTTyCmsDHwdoh6nYHByxsOSeZ8symlBuEbXn62I5SRXeJN7BS15+bqcW2mm1TOQ08BQEPCJR6Qd4WZeFEhKbHV6EtYhHUwGpSASSMPuzQRThvJ0r2MTR7XSeC4MuUwsnvyWzPLIzT/t1MC/etW4NOtW3iCAKVu3Ak1q0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675387; c=relaxed/simple;
	bh=4eT42arjHZahFMfIjMyy36Kwmar0HoOMSXxsZ1ZTnoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cwES453qYTlTgVqCCIg9CkoRLwa/wvl8K3fCdGHoDbl1BcrLZsZN6ye7Lo1KSr7kmGV2kEre5as6hkEuKgiwLNqH/XBhKZcHZ2ziugtqwAv7SKFm4SSkNIrQoCTumXLr4ZFQitKk08M8+F/BUiUw3smoAEajUwk/qUVL2mtFucQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4N7tAEuw; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUoKby/jt/wDTZRAcUU8TlyAP1wXn+XpPrNGyDTUqHmSgV+8feYpuc+Q8eoNA0ZatQNYvrsSfpen/NTbDmQeIUOheJ4JMYLPGl1Fa/sqY2TEgZIYNXlFW5UY795irBTvMcRMR0YnSe/e9uO41164cVwqQYSWcn1gMKqCLWRRAR7omcW0tqqLnUHVUFEg6YI4wW2+bMl4y2LGOtMYyUfRTR3tudsXssqd5mg1EWsGO6uisAFqiaOXQTLM09L5N73KOoViRW0TvQgmMJRXueBalTPlMX1Rm8fBYxE4Dz6lRLrz9x+GNkS6u4An+6rxEnDMLPv81QVm/bChKPKbdff6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eT42arjHZahFMfIjMyy36Kwmar0HoOMSXxsZ1ZTnoQ=;
 b=MX0I6rv2Zcvnvz+a9AYmGDN7nyXaos2sx2Ol14FpOeEXWsMotYtfk2fOhxt1VH0nv60UC8HpMgI88NIcOnov9lzboqky/2aOa6IPB4Bw8KD0VlVHJv2DMNK4o2qCQd01AhZjf72GqRaSQBWuxBrFbDh16jIF6TxIBMnkK/oo6B8MZzJ5+pEtPj+/cbMeqSfrDo5soOcy247y3xpHYnbOO+NZ1xHpkA1/QNeb0igOPzw42mlRWntm7kICqBUNV5nBn7ab1QR0W5lx+/Y0P7e+X0j20y/+xFzqM8SHy6ErBVdeCaGR2AcKOf0EC1lDjp8MXC4MyeHXzczwUPNHIqM0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eT42arjHZahFMfIjMyy36Kwmar0HoOMSXxsZ1ZTnoQ=;
 b=4N7tAEuw+l2YL4XyjWwmevsxqaWps0X2hHrl9uDcSf4s0K5CSP4ffUsBJGQ9jE7ywfO9k5LwlWyrVW4nthUqoMmD7OYIVrfdRdyuWkWVdCNvFxJcKfSjams4u7cNUJ1QQ6DUCZoWBUinrjk4RfWm0Hir8bJiBWhLoFQxJ1spcjW5sme5o2gz+g8C9/fFQGQoujg7wvc/VhfwunjzAad4Qbe02z3jdWBDO/BB6pZK0G3o+SdSK0cjannvB/xYFTt1BJY8PVz5qJSxVL3LLnOJbl7F0wsW7cyb3UvgSlUJcsBwNM5lR6JahvzGE84Steu0PZSjcOdN7kt5KBFrPMC7Ng==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 IA3PR11MB9328.namprd11.prod.outlook.com (2603:10b6:208:579::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.34; Thu, 8 May 2025 03:36:17 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%3]) with mapi id 15.20.8699.012; Thu, 8 May 2025
 03:36:17 +0000
From: <Thangaraj.S@microchip.com>
To: <kuba@kernel.org>
CC: <Bryan.Whitehead@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <andrew@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 net-next] net: lan743x: configure interrupt moderation
 timers based on speed
Thread-Topic: [PATCH v1 net-next] net: lan743x: configure interrupt moderation
 timers based on speed
Thread-Index: AQHbvjuwfAb1ipuHUkysqrRCN9cngrPFgyeAgADVnICAAb5ugA==
Date: Thu, 8 May 2025 03:36:17 +0000
Message-ID: <32159cd4a320a492fd47b6c38cebdb9a994c8bf5.camel@microchip.com>
References: <20250505072943.123943-1-thangaraj.s@microchip.com>
	 <e2d7079b-f2d3-443d-a0e5-cb4f7a85b1e6@lunn.ch>
	 <42768d74fc73cd3409f9cdd5c5c872747c2d7216.camel@microchip.com>
	 <e489b483-26bb-4e63-aa6d-39315818b455@lunn.ch>
	 <20250506175441.695f97fd@kernel.org>
In-Reply-To: <20250506175441.695f97fd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|IA3PR11MB9328:EE_
x-ms-office365-filtering-correlation-id: 68cf5674-cbde-4f9b-6863-08dd8de17df0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mmg3Um9tZ0hreWdIZm9iT3FKK3IrdFhzWDJLcm1TNEJQM3hDcXZjSGxWUVZv?=
 =?utf-8?B?aWZBZ295ei9qSmdoYUVxaHhMck1iYW5sUnZuWG82a2tkL3lZK2hSME1TN3BQ?=
 =?utf-8?B?eXplYy9iS3BZWnJHMm1wOFVyRlhnamFkZHpjZisycGdMSUNGaFJYUStyeSs3?=
 =?utf-8?B?em9BbDhMTEk0ZUZaQUhIRmpURWVDZkRpaTVYYjEvM1NqMlVIeEJzbWFwR1RY?=
 =?utf-8?B?M0NjQWtVYUtaelVVcFVJa3A5NUtkQkZzeXlPeVdCRG91Ykp0M0FhbUJSRHdT?=
 =?utf-8?B?L2lLb1JuNE91eFdGbU5YL3BUTHZGZS9GY3dwVGNSWGRXZkJLd2NnUVhtbmZC?=
 =?utf-8?B?VFllWUVnNUJuNWozTmRGeFdWLzljM3RDZUdDaGdQN1ArQW0xQWI5L09SRGxQ?=
 =?utf-8?B?RGxWWGsvRUczM05NME9mM3NtZ1FZUUN6U1oxRDJxbFN2TTNMaHNaM0VYRWMw?=
 =?utf-8?B?ektZbGJPM1dLRnRIek5GSVRSeDhLdHB0WDZiVXhsOTBhUjVjSDV0dk9wMEgv?=
 =?utf-8?B?SFhxbzkrSEpsWGF1bE80eHlVN0pzZkVjSVJ1SUZpSFloTlFLRFhYVVFEZUdv?=
 =?utf-8?B?aUJNNjMvelVtUUQ1V1hHR1UxUzJLUysxUjBxWXJzWTZ5SUdWSjZ2K3NQOGht?=
 =?utf-8?B?K3J1eXIrUTRSQktoc05RTUFoWXErTEUzWTlmKy9KejB4ZXFWdXpwZGthL3I1?=
 =?utf-8?B?T3BBNFArdlJPRWMrNkx4T2NHZWlHeEZickhrZFpDcURZL1NxcVZOM1BXaXk5?=
 =?utf-8?B?a09jWHExZlNsM2ltMHN5b2dEbVpCd0Q5MzVtNFRCQk93LzFoaUt5S3hrdlZY?=
 =?utf-8?B?RTZhR0NCQ1RWSGR2ZTRPbEttMHpaak1WY2dpNjcwWksvenFsYmRkdUduNk5T?=
 =?utf-8?B?eE9uQ1JYTnBrekpIcjZCWnlacWhiQkdseGRtbVJFb2FxNlRiSm40YVdvS3No?=
 =?utf-8?B?dEJENnBqSUZmbDR6SWM0Z05EWnA3R0J0VWRYVVZLeVlvSm5HQ0MvblMrMFh5?=
 =?utf-8?B?NEpPd2tLb2VVcmRsVHFneTUzUGdZTmhveW5ybXI1Yy9hdnlVQnZxeCtNYVRn?=
 =?utf-8?B?Z2NXVjJHREptODJOU0E0czFnaUpzaDRmZVdnSWlYM1AreUpiUW9wS1dRbVE5?=
 =?utf-8?B?YWYyNWNsb1EweW1NSEVlWHI4OGkyMGRsbmRyang1WjN4NXlVTHk2NVlqSFJF?=
 =?utf-8?B?TnJNUFdIVG42dmk1V2ZIQXBTU2V0eXk2VHJCN3hQZ09QaXcxNXNuL2Z2R1d0?=
 =?utf-8?B?eThSSnRYd1Q5WW5LMTJpNnJDaHB2aFU0emRkZS8zaWVpRVQvRnpZaG9YZlRm?=
 =?utf-8?B?cyt1RXN3UUZNZGFhanoyRnl5WkY0RXVNV21nYjBSZk5wWlJGN25aaS93L0FF?=
 =?utf-8?B?alJTcGxzZHpJRHA2OHBXNnJHancwSjduNm1od3Z1UVpDWldUNHI4eUxQSU9k?=
 =?utf-8?B?bDM4bWE5d0p2RjBuL0kyWTV2d0wyUkRRZFRoSDJyd2JCS0hibk0xaC9ESE9F?=
 =?utf-8?B?eHBaT05aZUJhR3hub0VjREkzNnNneFpvYlYrVzI4MlhRWVkwYTRQN1BmaUM4?=
 =?utf-8?B?SlpGaSt5VVRzTVpOU2Y0Yi9iM0hjWHFOTHRRQTZZRDUzMGFyUTRqVjVPVFZw?=
 =?utf-8?B?Z2hsbjBXWGtMMWVlRUw0cWpXbXVMWW41MDRFR1hlL09RakxBeVJnWHN0NnlG?=
 =?utf-8?B?VTNwMWhRc3pXWUhuYlh6K0ErR1FldGsxV2Y2STBtd1VacG9PWXlISzAyTDh1?=
 =?utf-8?B?ejFJUi92TkNJenlJVUxkdjFhTzMxZFo1OHh6ZTNnNGdBNUJUZDBRZVV5QnBQ?=
 =?utf-8?B?Y0dGR1EvQWV3ZzljVGtTL1pQNGxEcERQUWV4cGQ5bk40bkpBSzY3cWZzU1RL?=
 =?utf-8?B?ZGZWb0VQa2FQNjZQQmVqUkdvS1VCK0RPZisrcGV6NStqVkphZ0t2YWtDcDI3?=
 =?utf-8?B?eVBMQnNhdldKWFFzVW0zSmVHTWFNa3A4MUxwQk52ZzVPYnVPeWZqVUZrcEEy?=
 =?utf-8?Q?MOtaihz0mG18DWjJ0nwU5XrGDDvMqQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODFYc1pMTUszNHRGRDRGek5sZEJXZEVIbTI1MWRmcnZvN3lUZTMwcE1ZYnBU?=
 =?utf-8?B?eW8zaUk0L1k3cHlrOFBhMmVJd0haQUs0UjloWWV2U3JHWkh0ZlZYYkdRU3Za?=
 =?utf-8?B?WDJEdzJpVGorYTg2QUd6NEw5L0FVNWRCOHdBaDdrYUU3dGlJMlhiTU1sYXk1?=
 =?utf-8?B?eUtuRXRLUG9TQ3VtUjJqaVV6K3k3Q2Z3eW5IS01WY09PNkpCcDRYUXVBQkpO?=
 =?utf-8?B?bWp1dVRKd3B2TTVReXlIMkZhbWplaTRKNUNva2h2T0V2MjZNUU51Y3BreFNo?=
 =?utf-8?B?a1pFdjUvNEJwamFnNHBtaEVMOWVMcktEd1NTanhXb3Q5RTloZFRLV0lwNFlF?=
 =?utf-8?B?T0k4THJvbDd3R0x3b1ZDL3VQMFRGNEd4bVlHaUxpY01BS1VGdWgvdjBVc1J4?=
 =?utf-8?B?OVFkZm94ckUxRm9SZ2REWkFDY1B0NWxHOGwxL0xsVGJ3MWxmMXVDSHlEbHNJ?=
 =?utf-8?B?cmdhMmFJN2VyM2FET3lVbUU5cUREempCMyt6K2pYbndyS3lFSXJnUFlleXV1?=
 =?utf-8?B?TnRIZVVJb3hsTmpCMVJpSndqanVzdFErRThUa0NSdmd6V3NVTGNEc2J4WXAw?=
 =?utf-8?B?V3V2cjJKM0lqbmZCbUJJWSt2ZWtQUnRyNkthZk1zUDNOT1N0VHhVTVpQMXZx?=
 =?utf-8?B?L2I2WWRFRWF0T0ZaUkw4VStUa2tMeElHdmZQS1dLQkh2SnNubmNsQ0J3b2dr?=
 =?utf-8?B?WmxFMlo1TE5FZDZTdUk2OGFiUGhXZU12NDE1WHFXY2ljdWxYc1M0QThsTzdw?=
 =?utf-8?B?ZWY3VS9Vb1loZy9Ja1IxNW5NMlViWk56eEZNTzV0NEtWbUlNNG1zQTBWWkxI?=
 =?utf-8?B?NnJ0RmswWGdqZGRBcTZQMVhnL0hIVE9wSHlBeXlyd1hMVzhPeVhaQnBuWVRq?=
 =?utf-8?B?UTNINmNhZW15SThMUnJXY212MkxMcldyOTBsa0IxSkFTN0hSaUxoYW5wT0M4?=
 =?utf-8?B?M2tKSmd0VDAvTGFraHBiREdtU2dHdG9xTU1obHRGSXVuak9zQXZlcElWVDhv?=
 =?utf-8?B?SjhVam4xQTJYTzk0eTFKclY5K2RmRkd5cTIrbkQ1TnNzcldESVdseXlGTEha?=
 =?utf-8?B?eUo1akdsYnFJYVo2NHhMMVp3L2hzbTRzWHE1a2pudjNNd3FNdGZsY1E3dDA4?=
 =?utf-8?B?MzVVLzlRUVA3MER1ZGh6aDV5M1ZtREduVlV0VU9uK2k4YjZaQUU3a25TZ1JL?=
 =?utf-8?B?WEkvaE1LaUNSdk03QnNBQ0JCLzJOMkJkekRIUTdvMWw5Zk9YbVQ3ZWVEeStt?=
 =?utf-8?B?S3BZbHJZcWo2aDkrRzV5V2tsckJNcThPdFMyQWJmRXBuNmxDTEdZUFVKNjk4?=
 =?utf-8?B?VFNlMlg2S1A0bUJpeWhrenU4NFlzZjBqZW16TDB5TWVFVnowaUpWN3JMR0hk?=
 =?utf-8?B?WjhnRjF5U2s2TmRTQVdtOCswdTd1YXZaS01TU0NCWFVGdTBTcHlMNGpDTDdk?=
 =?utf-8?B?OUtSbisrOWl0WDFqbTlybnU3VTZha3BCMThORi9Ed1l1QytqNmh3NnMxQ012?=
 =?utf-8?B?a1R1aE5xejlhTlpnNGJ4WllFYzhLVURpYlZFR1paNVVMZnBGVWVWcDdtQlpG?=
 =?utf-8?B?TUdlbWVGZm1tOFhMOTE1NW9JV25PT2F6TVBlQ1N1Y3l4RjExTGV4eCtNRnUv?=
 =?utf-8?B?Q1NTL3VrY0FqZVRhWUluZi9peVJzTGdaUGhZT0Q4MXF6ZGcxQmVvdTFlMUY2?=
 =?utf-8?B?ZVhHY2JXSGJ1WFUxV2liQjFnUTEzdXhJcFZXTDY2WGN5RUtxaHNQdnB1WmxF?=
 =?utf-8?B?R3RsTXJReWxsN3UyN2cwa04wNEtRV1NUbGRhdUcwcmRIQTA2YkxXcnI4L1NN?=
 =?utf-8?B?d3NZRGNFb0hNNmlEVmZyd0o4N3NkRXlSZ2xsMzVTUTdDcHIzUExQa0ZMU1lT?=
 =?utf-8?B?eGoxalkzZytYM1RzV0hCakd1UFFqeFpFbFZ6Y1ZlLzdDNVV0SnNROUdGVS80?=
 =?utf-8?B?NWMvYnVuTllrSkJCV3ZVem9VMEFQcEpUQ3M5SDM3Zzd1TUFHdWR3aXVPYllh?=
 =?utf-8?B?YStWVVM3NGloVjlpUGFpOEJkVXlWMTl0VDcwZnYxSzJLTUF4TVBFd1RVTGJi?=
 =?utf-8?B?OFNXSzJVMlJIRVU4Q3IwQnpSWENlbjVMYmNROWNiS0dxSkRLSkw4dHM5WExi?=
 =?utf-8?B?RFFwRmxmQ0dXM3BBUTlQWmg1L05rZ3o3cEhkQU1GdmxTd3c3YnhKUTdhUUdJ?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D2808785EA9C149B3D151C3BB23685D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cf5674-cbde-4f9b-6863-08dd8de17df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 03:36:17.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jw2j3icmxFREYHNbRohFKOJdVpiHdHlVw1AAu9D2cPoUlrnceDggv2K5Eey0snI7MRsHiprewMSxQKse/4empSPQj9WVLg5+dDBkNYYUHVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9328

SGkgQW5kcmV3ICYgSmFrdWIsDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2guDQoNCkkg
YWdyZWUgd2l0aCB5b3VyIGNvbW1lbnRzIGFuZCB3aWxsIGltcGxlbWVudCB0aGUgZXRodG9vbCBv
cHRpb24gdG8NCnByb3ZpZGUgZmxleGliaWxpdHksIHdoaWxlIGtlZXBpbmcgdGhlIGRlZmF1bHQg
YmVoYXZpb3IgYXMgZGVmaW5lZCBpbg0KdGhpcyBwYXRjaCBiYXNlZCBvbiBzcGVlZC4NCg0KVGhh
bmtzLA0KVGhhbmdhcmFqIFNhbXluYXRoYW4NCk9uIFR1ZSwgMjAyNS0wNS0wNiBhdCAxNzo1NCAt
MDcwMCwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZQ0KPiANCj4gT24gVHVlLCA2IE1heSAyMDI1IDE0OjEwOjA5ICswMjAwIEFuZHJl
dyBMdW5uIHdyb3RlOg0KPiA+ID4gV2UndmUgdHVuZWQgdGhlIGludGVycnVwdCBtb2RlcmF0aW9u
IHZhbHVlcyBiYXNlZCBvbiB0ZXN0aW5nIHRvDQo+ID4gPiBpbXByb3ZlDQo+ID4gPiBwZXJmb3Jt
YW5jZS4gRm9yIG5vdywgd2XigJlsbCBrZWVwIHRoZXNlIGZpeGVkIHZhbHVlcyBvcHRpbWl6ZWQg
Zm9yDQo+ID4gPiBwZXJmb3JtYW5jZSBhY3Jvc3MgYWxsIHNwZWVkcy4gVGhhdCBzYWlkLCB3ZSBh
Z3JlZSB0aGF0IGFkZGluZw0KPiA+ID4gZXRodG9vbA0KPiA+ID4gLWMvLUMgc3VwcG9ydCB3b3Vs
ZCBwcm92aWRlIHZhbHVhYmxlIGZsZXhpYmlsaXR5IGZvciB1c2VycyB0bw0KPiA+ID4gYmFsYW5j
ZQ0KPiA+ID4gcG93ZXIgYW5kIHBlcmZvcm1hbmNlLCBhbmQgd2XigJlsbCBjb25zaWRlciBpbXBs
ZW1lbnRpbmcgdGhhdCBpbiBhDQo+ID4gPiBmdXR1cmUNCj4gPiA+IHVwZGF0ZS4NCj4gPiANCj4g
PiBBcyB5b3Ugc2FpZCwgeW91IGhhdmUgb3B0aW1pc2VkIGZvciBwZXJmb3JtYW5jZS4gVGhhdCBt
aWdodCBjYXVzZQ0KPiA+IHJlZ3Jlc3Npb25zIGZvciBzb21lIHVzZXJzLiBXZSB0cnkgdG8gYXZv
aWQgcmVncmVzc2lvbnMsIGFuZCBpZg0KPiA+IHNvbWVib2R5IGRvZXMgcmVwb3J0IGEgcmVncmVz
c2lvbiwgd2Ugd2lsbCBoYXZlIHRvIHJldmVydCB0aGlzDQo+ID4gY2hhbmdlLg0KPiA+IElmIHlv
dSB3ZXJlIHRvIGltcGxlbWVudCB0aGlzIGV0aHRvb2wgb3B0aW9uLCB3ZSBhcmUgYSBsb3QgbGVz
cw0KPiA+IGxpa2VseQ0KPiA+IHRvIG1ha2UgYSByZXZlcnQsIHdlIGNhbiBpbnN0cnVjdCB0aGUg
dXNlciBob3cgdG8gc2V0IHRoZSBjb2FsZXNjZQ0KPiA+IGZvcg0KPiA+IHRoZXJlIHVzZSBjYXNl
Lg0KPiANCj4gSSBjb21wbGV0ZWx5IGFncmVlLiBQbGVhc2UgbGV0IHRoZSB1c2VycyBkZWNpZGUg
aG93IHRoZXkgd2FudCB0bw0KPiBiYWxhbmNlDQo+IHRocm91Z2hwdXQgdnMgbGF0ZW5jeS4NCj4g
LS0NCj4gcHctYm90OiBjcg0K

